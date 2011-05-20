Given /^a message created using "([^"]*)" protocol$/ do |protocol|
  @opts = { :config_path => "examples_helpers/config/", :template_path => "examples_helpers/config/templates/" }
  @message = Porteo::Message.new( "clave", protocol.to_sym, :default, @opts )

  @message.load_template( "alert" )
  @message.set_template_params( {:nombre => "Luis", :repeticiones => 5} )
end

When /^I send a message$/ do
  @message.send_message
end

Then /^message should have been received at "([^"]*)"$/ do |arg1|
  fail  
end

