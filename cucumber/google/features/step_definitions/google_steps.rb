Given /^I have opened "([^\"]*)"$/ do |url|
    visit url
end
When /^I search for "([^\"]*)"$/ do |term|
  fill_in "q", :with => term
  click_button "Google Search"
end
