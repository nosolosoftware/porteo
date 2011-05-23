Given /^Protocol params defined in "([^"]*)"$/ do |emitter|

  hash = YAML.load_file("examples_helpers/config/#{emitter}")

  @protocol.gw_config = hash[:mail][:default]
  @protocol.receiver = "info@nosolosoftware.biz"
end

When /^I send the message$/ do
  @protocol.send_message
end

Then /^The message should have been received at "([^"]*)"$/ do |receiver|
  fail
end
