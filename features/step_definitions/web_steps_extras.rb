Then /^I should see "([^"]*)" button/ do |name|
    find_button(name).should_not be_nil
end

Then /^I should not see "([^"]*)" button/ do |name|
    page.has_no_button?(name).should be_true
end
