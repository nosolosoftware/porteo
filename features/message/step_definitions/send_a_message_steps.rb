Given /^a message created using "([^"]*)" protocol$/ do |protocol|
  @opts = { :config_path => "examples_helpers/config/", :template_path => "examples_helpers/config/templates/" }
  @message = Porteo::Message.new( "clave", protocol.to_sym, :default,"alert", @opts )

  @message.set_template_params( {:nombre => "Luis", :repeticiones => 5} )
end

When /^I send a message$/ do
  @message.send_message
end

Then /^message should have been received at "([^"]*)"$/ do |arg1|
  fail  
end


Given /^a new email message$/ do
  @message =Porteo::Message.new
  @message.configure do
    @message.emitter = "clave"
    @message.protocol = "mail"

    @message.template_path = "./examples_helpers/config/templates/"
    @message.config_path = "./examples_helpers/config/"
    @message.receiver = "info@nosolosoftware.biz"
  end
end

Given /^the template "([^"]*)"$/ do | template |
  @message.template = template
end

Given /^the file "([^"]*)"$/ do | file |
  @message.name "Robinson"
  @message.attachments File.read( file )
end

When /^I send the message$/ do
  @message.send_message
end

Then /^the message should arrive with the attachment file "([^"]*)"$/ do |arg1|
  fail
end

