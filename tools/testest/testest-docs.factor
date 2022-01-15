USING: help.markup help.syntax kernel quotations io ;
IN: tools.testest

ARTICLE: "tools.testest" "Unit testing"
;

! if thou testest me, thou wilt find no wickedness in me

HELP: <{
{ $syntax "<{ test-quot -> expected-quot }>" }
{ $values { "test-quot" "quotation under test" } { "expected-quot" "quotation giving expected value(s)" } }
{ $description "Define a single unit test to run the quotation under test and compare against the expected value(s) as given by the second quotation" }
{ $examples { $example "<{ 3 5 + -> 8 }>" } { $example "<{ 3 5 * -> 15 }>" } }
;

HELP: ->
{ $syntax "<{ test-quot -> expected-quot }>" }
! { \ <{ \ }> } related-words
;

HELP: }>
{ $syntax "<{ test-quot -> expected-quot }>" }
! { \ <{ \ -> } related-words
;

ABOUT: "tools.testest"
