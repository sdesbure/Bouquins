# -*- coding: utf-8 -*-
@http://www.pivotaltracker.com/story/show/12051319
Feature: Registration
  In order to store  my personal data
  As an user
  I should be able to register

  @passed
  Scenario: sign up with captcha OK
    Given I am a new user
    When I am on the home page
    And I follow "S'enregistrer"
    And I fill in "user_email" with "toot@toot.com"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "12345678"
    And Recaptcha is in test mode
    And I press "Sign up"
    Then I should see "Déconnexion"

  @passed
  Scenario: sign up with captcha NOK
    Given I am a new user
    When I am on the home page
    And I follow "S'enregistrer"
    And I fill in "user_email" with "toot@toot.com"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "12345678"
    And Recaptcha is failing
    And I press "Sign up"
    Then I should see "Sign up"

