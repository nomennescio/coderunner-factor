! Copyright 2019 nomennescio

! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU Lesser Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Lesser Public License for more details.
!
! You should have received a copy of the GNU Lesser Public License
! along with this program.  If not, see <https://www.gnu.org/licenses/>.

USING: accessors continuations debugger formatting io io.styles kernel locals math namespaces
parser prettyprint prettyprint.config quotations sequences system ;
IN: tools.testest

: describe#{ ( description -- starttime ) nl "<DESCRIBE::>%s" printf nl nano-count ;
: it#{ ( description -- starttime ) nl "<IT::>%s" printf nl nano-count ;
: }# ( starttime -- ) nano-count swap - 1000000 / nl "<COMPLETEDIN::>%f ms" printf nl ;

! line internal unformatted linefeed, to be used in single-line test result messages

: lf ( -- ) "<:LF:>" write ;

: pprint-unlimited ( obj -- ) [ pprint ] without-limits ;

: seq. ( seq -- )
  [
    [ lf pprint-unlimited ]
    [ drop [ error-in-pprint ] keep write-object ]
    recover
  ] each
;

! user redefinable test result messages

SYMBOL: test-passed.
SYMBOL: test-failed.

[ "Test Passed" write ] test-passed. set-global
[ "Test Failed : " write error. ] test-failed. set-global

<PRIVATE

: passed. ( -- ) test-passed. get call( -- ) ; inline
: failed. ( error -- ) test-failed. get call( error -- ) ; inline

: passed# ( -- ) nl "<PASSED::>" write ;
: failed# ( -- ) nl "<FAILED::>" write ;

:: (unit-test) ( test expected -- )
  [ { } test with-datastack { } expected with-datastack assert-sequence= passed# passed. nl ]
  [ failed# failed. nl ] recover
;

PRIVATE>

M: assert-sequence error.
  [ "Expected :" write expected>> seq. ]
  [ lf "but got :" write got>> seq. ] bi
;

DEFER: -> delimiter
DEFER: }> delimiter
SYNTAX: <{ \ -> parse-until >quotation suffix! \ }> parse-until >quotation suffix! \ (unit-test) suffix! ;
