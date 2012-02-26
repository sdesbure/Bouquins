@http://www.pivotaltracker.com/story/show/15205381
Feature: An user should be able to buy on Amazon a book he has read and he doesn't own
  In order to buy a book he's interested
  As a customer
  I want to be able to go to Amazon to buy the editions of the book even if I have read it


  Scenario Outline: Show or hide the buy link 
    Given I am a new, authenticated user
    And the book: "1" exists with title: "book1"
    And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
    And I've <action> the book "book1"
    When I go to the user's <page> page
    Then I should see "book1"
    And I should <result> "L'acheter"


    Examples:
      |    action    |    page    |  result |
      |     read     |    show    |   see   |
      |     read     | read_books |   see   |
      | read and own |    show    | not see |
      | read and own | read_books | not see |
