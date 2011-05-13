Given /^a template files location "([^"]*)"$/ do |template_path|
  @opts[:template_path] = template_path
end

Given /^a new message by emitter, protocol, profile, custom location and custom template location$/ do
  @message = Porteo::Message.new( @emitter, @protocol, @profile, @opts )
end

When /^I set template to "([^"]*)"$/ do |template|
  @message.set_template( template )
end

Then /^template should be set to a "([^"]*)"$/ do |template_file|
  @message.template_file.should == template_file
end

