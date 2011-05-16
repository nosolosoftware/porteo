Given /^I have a template$/ do
  @template = {:body => "hola que tal <%= nombre %> yo bien, asi que agarrame lo que rima"
              }

  @param = ["Pepote"]
end

Given /^I have a protocol$/ do
  @protocol = Porteo::Protocol.new( {} )
end

When /^I set the variables of the template$/ do
  @protocol.set_template_variables( @template, #template
                                   @param #variables
                                  )
end

Then /^the protocol should respond to the variables$/ do
  @protocol.message.should == "hola que tal Pepote yo bien, asi que agarrame lo que rima"
end
