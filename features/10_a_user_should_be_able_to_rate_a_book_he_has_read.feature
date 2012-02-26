@http://www.pivotaltracker.com/story/show/904395 @book
Feature: A user should be able to rate a book he has read
  In order to remember if I liked or not a book
  As a customer
  I should be able to rate the read books

  Scenario Outline: Showing my rate of a read book on the user's page and index
    Given I <auth> a new, authenticated user
    And the book: "1" exists with title: "Pro Git"
    And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
    And I've <read> the book "Pro Git"
    And I <own> the book "Pro Git"
    And I've <rated> "3" the book "Pro Git"
    When I go to the <page> page
    And I <fill> in "q" with "9782092531549"
    And I <press> "Rechercher"
    Then I <action1> see "Ma Note"
    And I <action2> see "3 sur 5"

    Examples:
      | auth   | read     | own       | rated     | page               | fill       | press       | action1    | action2    |
      | am     | read     | own       | rated     | user's show        | don't fill | don't press | should     | should     |
      | am     | read     | own       | rated     | user's read_books  | don't fill | don't press | should     | should     |
      | am     | read     | own       | rated     | user's owned_books | don't fill | don't press | should     | should     |
      | am     | not read | own       | rated     | user's owned_books | don't fill | don't press | should     | should not |
      | am     | read     | own       | rated     | root               | don't fill | don't press | should     | should     |
      | am     | read     | own       | not rated | root               | don't fill | don't press | should     | should not |
      | am not | not read | don't own | not rated | root               | don't fill | don't press | should not | should not |
      | am     | read     | don't own | rated     | book's search      | fill       | press       | should     | should     |
      | am     | read     | don't own | not rated | book's search      | fill       | press       | should     | should not |
      | am not | not read | don't own | not rated | book's search      | fill       | press       | should not | should not |

  @javascript
  Scenario Outline: Rating a book on the user's page
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I own the book "Pro Git"
    And I've read the book "Pro Git"
    When I go to the <page> page
    And I follow <follow>
    Then I should see <see>

    Examples:
      | page               | follow                                | see                                         |
      | user's show        | "Noter 2 sur 5"                       | "Votre note : 2 sur 5"                      |
      | user's read_books  | "Noter 2 sur 5"                       | "Votre note : 2 sur 5"                      |
      | user's owned_books | "Noter 2 sur 5"                       | "Votre note : 2 sur 5"                      |
      | root               | "Noter 2 sur 5" within "#left-table"  | "Votre note : 2 sur 5" within "#left-table" |
      | root               | "Noter 2 sur 5" within "#right-table" | "Votre note : 2 sur 5" within "#left-table" |

  @javascript
  Scenario: Showing my rate of a read book on the search page
    Given I am a new, authenticated user
    And the book: "1" exists with title: "book1"
    And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
    And I've read the book "book1"
    When I go to the user's show page
    And I fill in "q" with "9782092531549"
    And I press "Rechercher"
    And I follow "Noter 2 sur 5"
    Then I should see "Votre note : 2 sur 5"

  Scenario Outline: Showing the average rating of an owned book on the user show page
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I own the book "Pro Git"
    And I've read the book "Pro Git"
    And the average rate of the book "Pro Git" is "4"
    When I go to the user's <page> page
    Then I should see "Moyenne"
    And I should see "4.0 sur 5"

    Examples:
      | page        |
      | show        |
      | read_books  |
      | owned_books |

  Scenario: Showing the average rating of a book on the index page
    Given the book exists with title: "Pro Git"
    And the average rate of the book "Pro Git" is "4"
    When I go to the root page
    Then I should see "Note moyenne"
    And I should see "4.0 sur 5" within "#left-table"
    And I should see "4.0 sur 5" within "#right-table"

  Scenario: Showing the average rating of a book on the search page
    Given I am a new, authenticated user
    And the book: "1" exists with title: "book1"
    And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
    And the average rate of the book "book1" is "4"
    When I go to the user's show page
    And I fill in "q" with "9782092531549"
    And I press "Rechercher"
    Then I should see "Note moyenne"
    And I should see "4.0 sur 5"
