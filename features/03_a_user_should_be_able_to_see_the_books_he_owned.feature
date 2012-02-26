# -*- coding: utf-8 -*-
@http://www.pivotaltracker.com/story/show/904312 @book
Feature: A user should be able to see the books he owns
  Feature Owned Books
  In order to remember what books I've have
  As a customer
  I want to have a list of the book I've have

  @passed
  Scenario: View the title of the owned books
    Given I am a new, authenticated user
    And the book exists with title: "Pro Git"
    And I own the book "Pro Git"
    When I go to the user's show page
    Then I should see "Pro Git"
    And I should see "5 derniers livres achetés"
    And I should not see "Voir tous les livres m'appartenant"

  @passed
  Scenario: View the authors of the owned books
    Given I am a new, authenticated user
    And the following authors exist
      | author |     name     |
      |   Jo   |   Jo Nesbo   |
      |   Rob  | Robert Crais |
    And the book: "Pro" exists with title: "Pro Git"
    And the author: "Jo" is one of the book: "Pro"'s authors
    And the author: "Rob" is one of the book: "Pro"'s authors
    And I own the book "Pro Git"
    When I go to the user's show page
    Then I should see "Jo Nesbo"
    And I should see "Robert Crais"

  @passed
  Scenario: View the five first owned books only
    Given I am a new, authenticated user
    And the following books exist
      | book | title |
      |   1  | book1 |
      |   2  | book2 |
      |   3  | book3 |
      |   4  | book4 |
      |   5  | book5 |
      |   6  | book6 |
    And I own the following books:
      | title |
      | book1 |
      | book2 |
      | book3 |
      | book4 |
      | book5 |
      | book6 |
    When I go to the user's show page
    Then I should not see "book1"
    And I should see "book2"
    And I should see "book3"
    And I should see "book4"
    And I should see "book5"
    And I should see "book6"
    And I should see "Voir tous les livres m'appartenant"

  @passed
  Scenario: View all owned books in the owned_book page
    Given I am a new, authenticated user
    And the following books exist
      | book | title |
      |   1  | book1 |
      |   2  | book2 |
      |   3  | book3 |
      |   4  | book4 |
      |   5  | book5 |
      |   6  | book6 |
    And I own the following books:
      | title |
      | book1 |
      | book2 |
      | book3 |
      | book4 |
      | book5 |
      | book6 |
    When I go to the user's show page
    And I follow "Voir tous les livres m'appartenant"
    Then I should see "book1"
    And I should see "book2"
    And I should see "book3"
    And I should see "book4"
    And I should see "book5"
    And I should see "book6"
    And I should see "livres m'appartenant"
    And I should see "Retour"
