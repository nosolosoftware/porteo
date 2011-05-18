Given /^a message created using "([^"]*)" protocol$/ do |protocol|
  @opts = { :config_path => "examples_helpers/config/", :template_path => "examples_helpers/config/templates/" }
  @message = Porteo::Message.new( "nosolosoftware", protocol.to_sym, :admin, @opts )

  @message.load_template( "alert" )
  @message.set_template_params( {} )
end

When /^I send a message$/ do
  @message.send_message
end

Then /^message should have been received at "([^"]*)"$/ do |arg1|
  fail  
end

