Given /^a new message$/ do
  @opts = {:config_path => "./src/config/" } 
  @message = Porteo::Message.new( "clave", "mail", "default", "", @opts )
end

When /^I set "([^"]*)" as receiver of that message$/ do |receiver|
  @message.receiver = receiver
end

Then /^message should contain the "([^"]*)" receiver$/ do |receiver|
  @message.receiver.should == receiver
end

