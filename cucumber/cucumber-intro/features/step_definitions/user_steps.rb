Given /^I have users named (.*)$/ do |names|
  names.split(',').each do |name|
    User.create(:name => name)
  end
end

