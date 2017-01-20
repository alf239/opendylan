#!/usr/bin/env ruby
# Run in a source directory. Make sure debian/changelog is updated if needed.
# When building for x86 (32 bit), make sure MPS sources are available in the mps-kit subdirectory.
# When building for x86_64, make sure you increase the stack size (eg, ulimit -s 20000)

# Required dependencies:
# sudo apt-get install automake gcc libgc-dev rubygems ruby-dev debugedit python-sphinx
# sudo gem install fpm

require 'fileutils'
include FileUtils

# Create staging area
STAGING_DIR=`mktemp -d`.chomp
STAGING_DIR_DEBUG=`mktemp -d`.chomp
INSTALL_DIR="/usr/lib/opendylan"

additional_fpm_flags=""
configure_flags="--prefix=#{INSTALL_DIR}"

mkdir_p "#{STAGING_DIR}/usr/bin"

#system("make clean 2> /dev/null") # Clean up in case we start from a dirty directory
system("./autogen.sh") # Will return errors, but safe to ignore

# Add MPS configure flag for 32 bit x86
if(`uname -m` =~ /i686/)
  configure_flags << " --with-mps=#{Dir.pwd}/mps-kit"
  jamfile="sources/jamfiles/x86-linux-build.jam"
else
  jamfile="sources/jamfiles/x86_64-linux-build.jam"
end

# Add libgc dependency for 64 bit x86
if(`uname -m` =~ /x86_64/)
  additional_fpm_flags << ' -d "libgc-dev (>= 0)"'
end

# Configure and build 
puts "Configuring with #{configure_flags}"
system("./configure #{configure_flags}") || exit(1)
system("make") || exit(1)

# Add libgc dependency for 64 bit x86
if(`uname -m` =~ /x86_64/)
  additional_fpm_flags << ' -d "libgc-dev (>= 0)"'
end

# Install into staging area
system("make install DESTDIR=#{STAGING_DIR}") || exit(1)

# Build manpages and move them into the staging directory
system  "make -C documentation/man-pages man"
mkdir_p "#{STAGING_DIR}/usr/share/man/man1/"
Dir["documentation/man-pages/build/man/*.1"].each { |f| cp(f, "#{STAGING_DIR}/usr/share/man/man1/") }
Dir["#{STAGING_DIR}/usr/share/man/man1/*"].each { |f| system("gzip #{f}") }

# Move all the debug files to /usr/lib/debug/lib/opendylan in the STAGING_DIR_DEBUG.
Dir["#{STAGING_DIR}/**/*.dbg"].each do |file|
  target_file = file.sub(/^#{STAGING_DIR}/, "#{STAGING_DIR_DEBUG}/usr/lib/debug") #.sub(/\.dbg$/. '')
  if target_file !~ /^#{STAGING_DIR_DEBUG}/
    puts "Debug file new path is outside the debug staging dir, exiting."
    exit(1)
  end
  FileUtils.mkdir_p File.dirname(target_file)
  File.rename(file, target_file)
  # Edit debug information of the debug files.
  # I haven't gotten this to work yet...
  #system("debugedit -b \"#{Dir.pwd}/Bootstrap.3/build}\" -d \"/usr/lib/debug/lib/opendylan\" \"#{target_file}\"") || exit(1)
end

srcdir = Dir.pwd
# Create symlinks in /usr/bin for everything in /usr/lib/opendylan/bin
Dir.chdir "#{STAGING_DIR}/usr/bin"
Dir["../lib/opendylan/bin/*"].each { |f| FileUtils.ln_s(f, File.basename(f)) }
Dir.chdir srcdir

VERSION=`./Bootstrap.3/bin/dylan-compiler -shortversion`.chomp

# Generate the actual deb package
FPM_CMD=<<EOF
fpm -s dir -t deb -n opendylan --deb-changelog packages/unix/debian/changelog -v #{VERSION} -C #{STAGING_DIR} -p opendylan-VERSION_ARCH.deb \
    -d "gcc (>= 0)" -d "libc6-dev (>= 0)" #{additional_fpm_flags} -m "Wim Vander Schelden <wim@fixnum.org>" \
    --license MIT --url "http://opendylan.org/" --vendor "Dylan Hackers" --description "A Dylan compiler
    Dylan is a multi-paradigm programming language. It is a
    object-oriented language and is well suited for a
    functional style of programming.
    Though Dylan is a dynamic language, it was carefully
    designed to allow compilation to efficient machine code." \
    usr/lib/opendylan usr/bin usr/share/man
EOF

puts FPM_CMD
system(FPM_CMD) || exit(1)

FPM_CMD_DBG=<<EOF
fpm -s dir -t deb -n opendylan-dbg --deb-changelog packages/unix/debian/changelog -v #{VERSION} -C #{STAGING_DIR_DEBUG} -p opendylan-dbg-VERSION_ARCH.deb \
    -d "opendylan (= #{VERSION})" -m "Wim Vander Schelden <wim@fixnum.org>" \
    --license MIT --url "http://opendylan.org/" --vendor "Dylan Hackers" --description "OpenDylan debug symbols" \
    usr/lib/debug
EOF

puts FPM_CMD_DBG
system(FPM_CMD_DBG) || exit(1)

rm_rf STAGING_DIR
rm_rf STAGING_DIR_DEBUG

# Check the generated package for problems
#system("lintian *.deb")
