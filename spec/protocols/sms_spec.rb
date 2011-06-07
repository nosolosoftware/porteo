# encoding: UTF-8

require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'yaml'

describe Sms_protocol do
  
  describe "Check required fields" do

    before(:each) do
      @template = YAML.load_file( 'examples_helpers/config/templates/private.sms' )
      gw_config = YAML.load_file( 'examples_helpers/config/clave.emitter' )

      @protocol = Porteo::Mail_protocol.new( gw_config[:sms][:default] )
    end

    # Check to sections
    it "should raise an exception if text is longer than 160 characters" do
      @template[:template][:text] = "a"*161

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError
    
      # Check the double count of extended gsm symbols
      @template[:template][:text] = "a"*159 + "€"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError

    end

    # Check to sections
    it "should raise an exception if country code is not correct" do
      @template[:template][:code] = "1"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError

      @template[:template][:code] = "12345"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError
    end

    # Check to sections
    it "should raise an exception if phone number is not correct" do
      @template[:template][:phone] = "12345678"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError 
    end

    # Check to sections
    it "should raise an exception if sender is not correct" do
      @template[:template][:sender] = "John Doe"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError

      @template[:template][:sender] = "FranciscoIbañezDeGuzman"

      @protocol.set_template( @template[:template].to_s, @template[:requires] )

      lambda{ 
        @protocol.send_message
      }.should raise_error ArgumentError
    end
  end
end
