# -*- coding: utf-8 -*-
@http://www.pivotaltracker.com/story/show/15205399
Feature: An user should be able to buy on Amazon a book he hasn't read and owned
  In order to buy a book he's interested
  As a customer
  I want to be able to go to Amazon to buy the editions of the book

  Scenario: View the buy link for unread and unowned books
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  When I go to the user's show page
  And I fill in "q" with "9782092531549"
  And I press "Rechercher"
  Then I should see "book1"
  And I should see "L'acheter"

  Scenario: view the buy link for owned book on the index page for an unauthenticated guy
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I go to the root page
  And I follow "Se déconnecter"
  When I go to the root page
  And I fill in "q" with "9782092531549"
  Then I should see "book1"
  And I should see "L'acheter"

  Scenario: view the buy link for owned book on the index page for an unowned book
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I some other guy own the book "book1"
  When I go to the root page
  Then I should see "L'acheter"

  Scenario: view the buy link for owned book on the index page for an unauthenticated guy
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I own the book "book1"
  And I go to the root page
  And I follow "Se déconnecter"
  When I go to the root page
  Then I should see "L'acheter"

  Scenario: don't view the buy link for owned book on user show page
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I've read the book "book1"
  And I own the book "book1"
  When I go to the user's show page
  Then I should not see "L'acheter"

  Scenario: don't view the buy link for owned book on user read_books page
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I've read the book "book1"
  And I own the book "book1"
  When I go to the user's read_books page
  Then I should not see "L'acheter"

  Scenario: don't view the buy link for owned book
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I've read the book "book1"
  And I own the book "book1"
  When I go to the user's show page
  And I fill in "q" with "9782092531549"
  And I press "Rechercher"
  Then I should not see "L'acheter"

  Scenario: don't view the buy link for owned book on the index page
  Given I am a new, authenticated user
  And the book: "1" exists with title: "book1"
  And the edition exists with isbn10: "2092531549", isbn13: "9782092531549", book: book "1", amazon_url: "http://www.buy.me", price: "10"
  And I've read the book "book1"
  And I own the book "book1"
  When I go to the root page
  Then I should not see "L'acheter"
