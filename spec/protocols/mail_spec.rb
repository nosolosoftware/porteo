require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'yaml'

describe Mail_protocol do
  
  describe "Check required fields" do

    before(:each) do
      @template = YAML.load_file( 'examples_helpers/config/templates/alert.mail' )
      gw_config = YAML.load_file( 'examples_helpers/config/clave.emitter' )

      @protocol = Porteo::Mail_protocol.new( gw_config[:mail][:default] )
    end

    # Check to sections
    it "should raise an exception if :to tag is no correct" do
      @template[:template][:to] = "www.mail.com"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )
      @protocol.set_template_params( :nombre=>'Luis', :repeticiones=>5 )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError
    end

    # Check to sections
    it "should not raise any exception if :to tag is correct" do
      @template[:template][:to] = "info@nosolosoftware.biz"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )
      @protocol.set_template_params( :nombre=>'Luis', :repeticiones=>5 )

      lambda{ 
        @protocol.send_message
      }.should_not raise_error Exception
    end
  end
end
