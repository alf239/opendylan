Module:       io-internals
Synopsis:     *standard-input*, *standard-output*, *standard-error*
Author:       Gary Palter and Jonathan Bachrach
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define variable *standard-input*
  = make(<file-stream>, locator: 0, file-descriptor: 0, direction: #"input");

define variable *standard-output*
  = make(<file-stream>, locator: 1,
         file-descriptor: 1, direction: #"output",
         stream-lock: make(<recursive-lock>));

define variable *standard-error*
  = make(<file-stream>, locator: 2,
         file-descriptor: 2, direction: #"output",
         stream-lock: make(<recursive-lock>));

