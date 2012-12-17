When /^I set the param "([^"]*)" with argument "([^"]*)"$/ do | param, argument |
  @message.emitter = "clave"
  @message.receiver = "homer@nosolosoftware.biz"
  @message.send( (param + "=" ).to_sym, argument )
end

Then /^Complete template should be "([^"]*)"$/ do | message |
  @message.show_message.should == {:from => "homer@nosolosoftware.biz", :body => message }.to_s
end

When /^I set the template path "([^"]*)"$/ do | template_path |
  @message.template_path = template_path
end

When /^I set the config path "([^"]*)"$/ do | config_path |
  @message.config_path = config_path  
end


