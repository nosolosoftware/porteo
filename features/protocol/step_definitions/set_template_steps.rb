Given /^I have a template$/ do
  @template = {:body => "hola que tal <%= param[:nombre] %> yo bien, asi que agarrame lo que rima"
              }.to_s
  @param = { :nombre => "Pepote" }

  @requires = [ :nombre ]
end

Given /^I have a protocol$/ do
  @protocol = Porteo::Protocol.new( {} )
end

When /^I set the variables of the template$/ do
  @protocol.set_template( @template, @requires )
  @protocol.set_template_params( @param )
end

Then /^the protocol should respond to the variables$/ do
  @protocol.message.should == { :body => "hola que tal Pepote yo bien, asi que agarrame lo que rima" }.to_s
end
