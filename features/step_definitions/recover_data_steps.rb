
# EXPRESS THE CODE YOU WISH YOU HAD

Given /^I want to set "([^"]*)" as emitter$/ do |emitter|
  # fail if the file dont exist
  fail unless File.exist?("#{Porteo::ROOT_PATH}/#{emitter}")
end
When /^I create a message with "([^"]*)" emitter$/ do |emitter|
  # When i create a new instance with that emitter
  @my_msg = Porteo::Message.new(emitter.to_sym)
  
end
Then /^message should contain the data stored in emitter file$/ do
  # Then the msg should contain the same info as the file
  my_yaml = File.open("#{Porteo::ROOT_PATH}/#{emitter}"){ |yaml_obj|
    YAML::load( yaml_obj )
  }
  # Now lets compare with @my_msg

  @my_msg.emitter.should == my_yaml[:emitter]
  # ... etc

end

