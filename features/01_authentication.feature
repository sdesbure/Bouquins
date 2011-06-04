@http://www.pivotaltracker.com/story/show/904396 @book
Feature: Authentication
  In order to retrieve my personal data
  As an user
  I should be able to sign in

  Scenario: sign in
    Given I am a new, authenticated user
    Then I should see "Déconnexion"

  Scenario: sign out
    Given I am a new, authenticated user
    When I follow "Déconnexion"
    Then I should see "Connexion"

  Scenario: sign in link
    Given I am on the home page
    Then I should see "Connexion"
