! Copyright 2018-2019 nomennescio
! Released to the public domain

USING: kata.preloaded kata.solution prettyprint tools.test debugger continuations ;
IN: kata.test

: run-tests ( -- )
  "Running tests" .
  {  0 } [ 0 1 solution ] unit-test
  {  0 } [ 1 0 solution ] unit-test
  {  1 } [ 1 1 solution ] unit-test
  { 15 } [ 3 5 solution ] unit-test
  "Finished tests" .
  [ {  1 } [ 0 0 solution ] unit-test ] [ error. ] recover
  "Should fail" .
;

MAIN: run-tests
