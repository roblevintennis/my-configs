Before do
  @adder = Adder.new
end

Given /^I enter (.*) in to the adder$/ do |n|
  @adder.push(n.to_i)
end
When /^I press add$/ do
  @result = @adder.add
end
Then /^the result should be (.*) on the screen/ do |r|
  @result.should == r.to_i
end

