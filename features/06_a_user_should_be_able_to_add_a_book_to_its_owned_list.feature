# -*- coding: utf-8 -*-
@http://www.pivotaltracker.com/story/show/904316 @book
Feature: An user should be able to add a book to its owned list
    In order to mark a book as read
    As an user
    I should be add a book in my read list

    @passed
    Scenario: Adding a read book
      Given I am a new, authenticated user
      And the book: "1" exists with title: "book1"
      And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
      And I've read the book "book1"
      When I go to the user's show page
      And I press "Je le possède"
      And I go to the user's owned_books page
      Then I should see "book1"

    @passed
    Scenario: Adding an unread book
      Given I am a new, authenticated user
      When I go to the user's show page
      And I fill in "q" with "2092531549"
      And I press "Rechercher"
      And I press "Je le possède"
      Then I should be on the user's show page
      And I should see "T'choupi aime sa nounou"
      And I should see "Thierry Courtin"

    @passed
    Scenario: Not showing "Je le possède" when book is already owned
      Given I am a new, authenticated user
      And the book: "1" exists with title: "book1"
      And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
      And I've read the book "book1"
      And I own the book "book1"
      When I go to the user's show page
      Then I should not see "Je le possède" button

    @passed
    Scenario: Not showing "Je le possède" when book is already owned on unread book
      Given I am a new, authenticated user
      And the book: "1" exists with title: "book1"
      And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1"
      And I own the book "book1"
      When I go to the user's show page
      And I fill in "q" with "2092531549"
      And I press "Rechercher"
      Then I should not see "Je le possède" button
