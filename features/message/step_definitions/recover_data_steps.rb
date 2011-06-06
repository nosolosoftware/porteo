# EXPRESS THE CODE YOU WISH YOU HAD

Given /^a emitter "([^"]*)"$/ do |emitter|
  @emitter = emitter
end

Given /^a protocol "([^"]*)"$/ do |protocol|
  @protocol = protocol
end

Given /^a profile "([^"]*)"$/ do |profile|
  @profile = profile.to_sym
end

When /^I create a new message by emitter, protocol and profile$/ do
  opts = { :config_path => "./src/config/" }
  @message = Porteo::Message.new( @emitter, @protocol, @profile,"", opts )
end

Then /^emitter should be "([^"]*)"$/ do |emitter|
  @message.emitter.should == emitter
end

Then /^protocol should be "([^"]*)"$/ do |protocol|
  @message.protocol.should == protocol
end

Then /^profile should be "([^"]*)"$/ do |profile|
  @message.profile.should == profile.to_sym  
end

Then /^configuration path should be "([^"]*)"$/ do |config_path|
  @message.config_path.should == config_path
end

Then /^receiver should be empty$/ do
  @message.receiver.should == nil
end

Then /^template params should not been initialized$/ do
  @message.template.should == ""
  @message.template_params.should == {}
  @message.template_requires.should == []
end

