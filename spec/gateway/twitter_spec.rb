require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'yaml'

describe Porteo::Twitter_gateway do
  # Check that respong to all methods
  it "should respond to all methods that are in the parent class" do
    lambda{
      Porteo::Twitter_gateway.new( {} ).should respond_to( :send_message )
    }.should_not raise_error
  end

  # Check that send a twitt
  it "should send a twitt" do
    config = YAML.load_file( './examples_helpers/config/clave.emitter' )

    my_gw = Porteo::Twitter_gateway.new( config[:twitter][:default] )

    # set the message
    message = { :body => "Im tweeting using Porteo ^_^" }

    # and finally send the message
    my_gw.send_message( message )
  end
end
