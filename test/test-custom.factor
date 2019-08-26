! Copyright 2019 nomennescio

USING: accessors debugger io kernel namespaces sequences tools.testest ;
IN: tests

! : passed. ( -- ) "Just passed" write ;
! : failed. ( -- ) "Just failed" write ;

: custom1 ( -- )

  [ "Just passed" write ] test-passed. set
  [ "Just failed" write drop ] test-failed. set

  "short strings" it#{
    <{ "Hello World!" -> "Hello World!" }>
    <{ "Hello Worlds!" -> "Hello Worlds!" }>
  }#
  
  "failing compares" it#{
    <{ "Hello World!" -> "Hello Worlds!" }>
    <{ "Hello Worlds!" -> "Hello Worlds! " }>
  }#
;

M: assert-sequence error.
  [ "Actually expected :" write expected>> seq. ]
  [ lf "but instead got :" write got>> seq. ] bi
;

: custom2 ( -- )

  [ "Test passed" write ] test-passed. set
  [ error. ] test-failed. set

  "short strings" it#{
    <{ "Hello World!" -> "Hello World!" }>
    <{ "Hello Worlds!" -> "Hello Worlds!" }>
  }#
  
  "failing compares" it#{
    <{ "Hello World!" -> "Hello Worlds!" }>
    <{ "Hello Worlds!" -> "Hello Worlds! " }>
  }#
;

: run-tests ( -- )
  "custom message" describe#{
    custom1
    custom2
  }#
;

MAIN: run-tests
