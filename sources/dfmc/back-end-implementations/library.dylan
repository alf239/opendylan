module: dylan-user

define library dfmc-back-end-implementations
  use dylan;

  use dfmc-c-back-end;           // C backend
  use dfmc-c-linker;             // C linker
  use dfmc-llvm-back-end;        // LLVM backend
  use dfmc-llvm-linker;          // LLVM linker
  use dfmc-java-back-end;        // JVM backend
  use dfmc-java-linker;          // JVM linker
end library dfmc-back-end-implementations;
