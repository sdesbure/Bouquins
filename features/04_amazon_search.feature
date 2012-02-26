# -*- coding: utf-8 -*-
@http://www.pivotaltracker.com/story/show/904400 @book
Feature: Amazon search
  In order to find informations about a book
  As an user
  I should be able to search via Amazon


  Scenario Outline: search
    Given I am a new, authenticated user
    When I go to the user's show page
    And I fill in "q" with "<request>"
    And I press "Rechercher"
    Then I should be on the book's search page
    And I should see "T'choupi"
    And I should see "Thierry Courtin"
    And I should see "Je l'ai lu" button
    And I should see "Je le possède" button

    Examples:
      |         request         |
      |       2092531549        |
      |      9782092531549      |
      |     Thierry Courtin     |
      | T'Choupi aime sa nounou |

  Scenario: search with unsigned user
    When I go to the book's search page
    And I fill in "q" with "9782092531549"
    And I press "Rechercher"
    Then I should be on the book's search page
    And I should see "T'choupi aime sa nounou"
    And I should see "Thierry Courtin"
    And I should not see "Je l'ai lu" button
    And I should not see "Je le possède" button
