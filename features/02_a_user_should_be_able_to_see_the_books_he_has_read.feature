@http://www.pivotaltracker.com/story/show/904313 @book
Feature: A user should be able to see the books he has read
  Feature Read Books
  In order to remember what books I've read
  As a customer
  I want to have a list of the book I've read

  @passed
  Scenario: View the title of the read books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I've read the book "Pro Git"
    When I go to the user's show page
    Then I should see "Pro Git"
    And I should see "5 derniers livres lus"
    And I should not see "Voir tous les livres lus"

  @passed
  Scenario: View the authors of the read books
    Given I am a new, authenticated user
    And the following authors exist
      | author |     name     |
      |   Jo   |   Jo Nesbo   |
      |   Rob  | Robert Crais |
    And the book: "Pro" exists with title: "Pro Git"
    And the author: "Jo" is one of the book: "Pro"'s authors
    And the author: "Rob" is one of the book: "Pro"'s authors
    And I've read the book "Pro Git"
    When I go to the user's show page
    Then I should see "Jo Nesbo"
    And I should see "Robert Crais"

  @passed
  Scenario: View the five first books only
    Given I am a new, authenticated user
    And the following books exist
      | book | title |
      |   1  | book1 |
      |   2  | book2 |
      |   3  | book3 |
      |   4  | book4 |
      |   5  | book5 |
      |   6  | book6 |
    And I've read the following books:
      | title |
      | book1 |
      | book2 |
      | book3 |
      | book4 |
      | book5 |
      | book6 |
    When I go to the user's show page
    Then save the page
    Then I should not see "book1"
    And I should see "book2"
    And I should see "book3"
    And I should see "book4"
    And I should see "book5"
    And I should see "book6"
    And I should see "Voir tous les livres lus"

  @passed
  Scenario: View all read books in the read_book page
    Given I am a new, authenticated user
    And the following books exist
      | book | title |
      |   1  | book1 |
      |   2  | book2 |
      |   3  | book3 |
      |   4  | book4 |
      |   5  | book5 |
      |   6  | book6 |
    And I've read the following books:
      | title |
      | book1 |
      | book2 |
      | book3 |
      | book4 |
      | book5 |
      | book6 |
    When I go to the user's show page
    And I follow "Voir tous les livres lus"
    Then I should see "book1"
    And I should see "book2"
    And I should see "book3"
    And I should see "book4"
    And I should see "book5"
    And I should see "book6"
    And I should see "livres lus"
    And I should see "Retour"
