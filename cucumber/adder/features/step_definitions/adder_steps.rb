Given /^I enter (.*) in to the adder$/ do |n|
  adder = Adder.new
  adder.push(n.to_i)
end

