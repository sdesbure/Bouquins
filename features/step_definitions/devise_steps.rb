Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am not a new, authenticated user$/ do
end


Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)" and login "([^\"]*)"$/ do |email, password, login|
  User.new(:email => email,
           :login => login,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  step %{a user exists with email: "#{email}", password: "#{password}"}
  step %{I am not authenticated}
  step %{I am on the home page}
  step %{I follow "Se connecter"}
  step %{I fill in "user_email" with "#{email}"}
  step %{I fill in "user_password" with "#{password}"}
  step %{I press "Se connecter"}
end

Given /^Recaptcha is in test mode$/ do
  Rack::Recaptcha.test_mode!
end


Given /^I am a new user$/ do
  User.find(:all).count.should == 0
end


When /^Recaptcha is failing$/ do
  Rack::Recaptcha.test_mode! :return => false
end

