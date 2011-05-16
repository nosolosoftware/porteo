Given /^a message created using "([^"]*)" protocol$/ do |protocol|
  @opts = { :config_path => "./src/config/", :templates_path => "./src/config/templates" }
  @message = Porteo::Message.new( "nosolosoftware", protocol.to_sym, :admin, @opts )

  @message.expand_template( "alert" )
  @message.set_template_params( {} )
end

When /^I send a message$/ do
  @message.send_message
end

Then /^message should have been received at "([^"]*)"$/ do |arg1|
  fail  
end

