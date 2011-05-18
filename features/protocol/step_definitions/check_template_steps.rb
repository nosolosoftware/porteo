Then /^The protocol shouldn't respond to the variables$/ do
  # express the regexp above with the code you wish you had
  lambda{
    @protocol.message
  }.should raise_error( ArgumentError )
end
