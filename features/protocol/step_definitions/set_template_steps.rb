Given /^I have a template "([^"]*)"$/ do |template_file|
  hash = YAML.load_file( template_file )
  @template = hash[:template].to_s

  @requires = hash[:requires]
end

Given /^I have params "([^"]*)"$/ do |params|
  @param = eval params
end
                        
Given /^I have a protocol "([^"]*)"$/ do |protocol|
  @protocol = Porteo.const_get( protocol.to_sym ).new( {} )
end

When /^I set the template$/ do
  @protocol.set_template( @template, @requires )
  @protocol.set_template_params( @param )
end

Then /^the protocol should respond to the variables "([^"]*)"$/ do |params| 
  hash = eval params
  @protocol.message.should == hash.to_s
end
