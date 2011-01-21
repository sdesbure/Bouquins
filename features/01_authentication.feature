Feature: Authentication
  In order to retrieve my personal data
  As an user
  I should be able to sign in

  Scenario: sign in
    Given I am a new, authenticated user
    Then I should be on the user's show page
    And I should see "Bienvenue, Sylvain"
