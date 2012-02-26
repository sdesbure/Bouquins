@http://www.pivotaltracker.com/story/show/15129201 @book
Feature: An user should be able to delete a book from its read list
  In order to remove from the read book list a book I've actually not read
  As a customer
  I want to be able to remove a book from the read book list

  @passed
  Scenario: View the remove link for read books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I've read the book "Pro Git"
    When I go to the user's read_books page
    Then I should see "Pro Git"
    And I should see "Enlever"

  @passed
  Scenario: Follow the remove link for read books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I've read the book "Pro Git"
    When I go to the user's read_books page
    And I follow "Enlever"
    Then I should see "Pro Git" within "#feedback"
    And I should not see "Pro Git" within ".table"
