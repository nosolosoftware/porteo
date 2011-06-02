Given /^a template files location "([^"]*)"$/ do |template_path|
  @opts[:template_path] = template_path
end

Given /^a new message by emitter, protocol, profile, custom location and custom template location$/ do
  @message = Porteo::Message.new( @emitter, @protocol, @profile, "", @opts )
end

When /^I set template to "([^"]*)"$/ do |template|
  @message.template_name = template 
end

Then /^template should be set to a "([^"]*)"$/ do |template|
  @message.template_name.should ==  template 
end

