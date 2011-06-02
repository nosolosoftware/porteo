When /^I create a new message using too few configuration parameters$/ do
  @opts = { :config_path => "examples_helpers/config/", :template_path => "examples_helpers/config/templates/" }
  @message = Porteo::Message.new( @emitter, @protocol, @profile, "message", @opts )

  @message.set_template_params( :message => "Luis" )
 
end

Then /^I should get an exception if I send the message$/ do
  lambda{ @message.send_message }.should raise_error ArgumentError, /Gateway Error. Too few arguments to connect./
end

