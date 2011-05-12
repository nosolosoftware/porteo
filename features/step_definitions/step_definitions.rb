Given /^a file called "([^"]*)"$/ do |filename|
  @filename = filename
end

Given /^a protocol "([^"]*)"$/ do |protocol|
  @protocol = protocol
end

Given /^a sending profile "([^"]*)"$/ do |profile|
  @profile = profile
end

When /^I create a message from a emitter file, protocol and profile$/ do
  fail # express the regexp above with the code you wish you had
end

Then /^message should contain the data stored in emitter file$/ do
  pending # express the regexp above with the code you wish you had
end

