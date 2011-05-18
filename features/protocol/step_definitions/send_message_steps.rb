Given /^Protocol params "([^"]*)"$/ do |gw_config|
  @protocol.gw_config = eval gw_config
end

When /^I send the message$/ do
    @protocol.send_message
end

Then /^The message should have been received at "([^"]*)"$/ do |receiver|
  fail
end
