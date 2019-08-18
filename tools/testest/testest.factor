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

USING: accessors continuations debugger formatting io kernel locals math prettyprint sequences system ;
IN: tools.testest

: describe#{ ( description -- starttime ) "\n<DESCRIBE::>%s\n" printf nano-count ;
: it#{ ( description -- starttime ) "\n<IT::>%s\n" printf nano-count ;
: }# ( starttime -- ) nano-count swap - 1000000 / "\n<COMPLETEDIN::>%d ms\n" printf ;

: passed# ( -- ) "\n<PASSED::>" print ;
: failed# ( -- ) "\n<FAILED::>" print ;

:: unit-test ( expected test -- )
  [ { }  test with-datastack expected assert-sequence= passed# ] [ failed# error. ] recover
;

M: assert-sequence error.
  [ "Expected :" print expected>> stack. ]
  [ ", but got :" print got>> stack. ] bi
;
