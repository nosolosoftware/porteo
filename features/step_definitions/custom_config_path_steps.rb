Given /^a configure files location "([^"]*)"$/ do |configure_path|
  @opts = {}
  @opts[:config_path] = configure_path
end

When /^I create a new message by emitter, protocol, profile and custom location$/ do
  @message = Porteo::Message.new( @emitter, @protocol, @profile, @opts )
end

