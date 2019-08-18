! Copyright 2018-2019 nomennescio
! Released to the public domain

USING: kata.preloaded kata.solution prettyprint tools.testest ;
IN: kata.test

: run-tests ( -- )
  "Sample tests" describe#{
    "Succeeding tests" it#{
      {  0 } [ 0 1 solution ] unit-test
      {  0 } [ 1 0 solution ] unit-test
      {  1 } [ 1 1 solution ] unit-test
      { 15 } [ 3 5 solution ] unit-test
    }#
    "Failing tests" it#{
      {  1 } [ 0 0 solution ] unit-test
    }#
  }#
;

MAIN: run-tests
