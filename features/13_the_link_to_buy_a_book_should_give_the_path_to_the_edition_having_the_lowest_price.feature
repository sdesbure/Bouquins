@http://www.pivotaltracker.com/story/show/15865375
Feature: The link to buy a book should give the path to the edition having the lowest price
  In order to buy a new book he's interested at the lowest price possible
  As a customer
  I want to be able to go to Amazon to buy the edition of the book which has the lowest price


  Scenario: Sort by price
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  Given the following editions exists:
    |   isbn10   |    isbn13     | book     |     amazon_url      | price |
    | 2092531546 | 9782092531546 | book "1" | http://www.buy.me/1 |   10  |
    | 2092531547 | 9782092531547 | book "1" | http://www.buy.me/2 |    8  |
    | 2092531548 | 9782092531548 | book "1" | http://www.buy.me/3 |   11  |
    | 2092531549 | 9782092531549 | book "1" | http://www.buy.me/4 |   10  |
  And I some other guy own the book "book1"
  When I go to the root page
  Then I should see "book1"
  And I should see a link to "http://www.buy.me/2" with text "L'acheter"
