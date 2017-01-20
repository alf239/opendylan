Module:    dylan-user
Synopsis:  An application library for test-suite access-path-test-suite
Author:       Peter S. Housel
Copyright:    Original Code is Copyright 2015 Gwydion Dylan Maintainers
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define library access-path-test-suite-app
  use access-path-test-suite;
  use testworks;
end;

define module access-path-test-suite-app
  use access-path-test-suite;
  use testworks;
end;
