Then /^I should see a link to "([^"]*)" with text "([^\"]*)"$/ do |url, text|
  page.should have_selector("a[href='#{ url }']") do |element|
    element.should contain(text)
  end
end

