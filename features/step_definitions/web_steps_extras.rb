When /^I don't fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
end

When /^I don't press "([^"]*)"$/ do |arg1|
end

Then /^I should see a link to "([^"]*)" with text "([^\"]*)"$/ do |url, text|
  page.should have_selector("a[href='#{ url }']") do |element|
    element.should contain(text)
  end
end

Then /^I should see "([^"]*)" button/ do |name|
    find_button(name).should_not be_nil
end

Then /^I should not see "([^"]*)" button/ do |name|
    page.has_no_button?(name).should be_true
end
