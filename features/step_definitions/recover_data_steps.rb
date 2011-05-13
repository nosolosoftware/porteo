# EXPRESS THE CODE YOU WISH YOU HAD

Given /^a emitter "([^"]*)"$/ do |emitter|
  @emitter = emitter
end

Given /^a protocol "([^"]*)"$/ do |protocol|
  @protocol = protocol.to_sym
end

Given /^a profile "([^"]*)"$/ do |profile|
  @profile = profile.to_sym
end

When /^I create a new message by emitter, protocol and profile$/ do
  opts = { :config_path => "./src/config/" }

  @message = Porteo::Message.new( @emitter, @protocol, @profile, opts )
end

Then /^gateway data should be the same defined in "([^"]*)" emitter at protocol "([^"]*)" using profile "([^"]*)" at path "([^"]*)"$/ do |emitter, protocol, profile, path|
  @message.gateway.params.should == YAML.load_file("#{path}#{emitter}.emitter")[protocol.to_sym][profile.to_sym]
end

