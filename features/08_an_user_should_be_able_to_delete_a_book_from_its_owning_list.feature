@http://www.pivotaltracker.com/story/show/15129233 @book
Feature: An user should be able to delete a book from its owning list
  In order to remove from the owned book list a book I've actually not owned
  As a customer
  I want to be able to remove a book from the owned book list

  @passed
  Scenario: View the remove link for owned books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I own the book "Pro Git"
    When I go to the user's owned_books page
    Then I should see "Pro Git"
    And I should see "Enlever"

  @passed
  Scenario: Follow the remove link for owned books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I own the book "Pro Git"
    When I go to the user's owned_books page
    And I follow "Enlever"
    Then I should see "Pro Git" within "#feedback"
    And I should not see "Pro Git" within ".table"
