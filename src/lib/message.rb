# Copyright 2011 NoSoloSoftware

# This file is part of Porteo.
# 
# Porteo is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Porteo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Porteo. If not, see <http://www.gnu.org/licenses/>.

require 'yaml'
require './src/lib/protocols/twitter_protocol'
require './src/lib/protocols/mail_protocol'
require './src/lib/protocols/sms_protocol'

module Porteo

  # Default configuration path 
  CONFIG_ROOT = "./config/"
  # Default templates path
  TEMPLATES_ROOT = "./config/templates/"
  # Default locales path
  LOCALES_ROOT = "./config/locales/"

  # A message which will be send by any protocol and gateway.
  # 
  # The content of a message will be defined in a template, a file
  # that contain differents sections each being one part of the message.
  # This templates will be processed with ERB so its can contain ruby
  # code to get more flexibility.
  #
  # The configuration options (for protocols and gateways) it set trought
  # emitter files, special files in YAML format.
  class Message
    # A hash containing message sections defined in the template.
    attr_reader :template_content
    # An array containing required fields to define the template.
    attr_reader :template_requires
    
    # The name of the protocol used to send the message.
    attr_accessor :protocol
    # Name of template used to send the message.
    attr_accessor :template
    # Parameters to set the fields defined in the template.
    attr_accessor :template_params
    # Path to configuration directory. It have to end in a slash.
    attr_accessor :config_path
    # Path to templates directory. It have to end in a slash.
    attr_accessor :template_path
    # The one who should receive the message.
    attr_accessor :receiver
    # Profile used to recover the gateway configuration.
    attr_accessor :profile
    # File used to load the configuration information.
    attr_accessor :emitter


    # Creates a new message.
    # @param [String] emitter File used to load the configuration information.
    # @param [String] protocol Protocol to be used (mail, sms, twitter).
    # @param [String] profile Profile to load gateway information.
    # @param [Hash] opts Options.
    # @option opts :config_path ("./config/") Configuration path.
    # @option opts :template_path ("./config/templates/") Templates path.
    def initialize( emitter = "", protocol = "", profile = "default", template = "", opts = {} )
      # config_path value should end in a trailing slash
      opts[:config_path] ||= CONFIG_ROOT
      @config_path = opts[:config_path]

      # template_path value should end in a trailing slash
      opts[:template_path] ||= TEMPLATES_ROOT
      @template_path = opts[:template_path] 
      
      # Instance variables initilization
      @template = template
      @template_params = {}
      @template_content = ""
      @template_requires = []

      @receiver = nil

      # Assign instance variables
      @emitter = emitter
      @profile = profile
      @protocol = protocol
    end

    # Convenience method to allow configuration options to be set in a block.
    # @return [nil]
    def configure
      yield self
    end

    # Assign values to fields defined in the template.
    # Overwrite all params set before.
    # @param [Hash] params The keys are the fields defined in the
    #   template which will be set to the hash value.
    # @return [nil]
    def set_template_params( params )
      @template_params = params 
    end

    # Send a message using protocol, content and configuration set before.
    # @return [nil]
    # @raise [ArgumentError] If emitter file is not valid or if protocol is not defined.
    def send_message
      load_template( @template )
      
      # Load configuration information for the gateway
      begin
        config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )
      rescue Errno::ENOENT
        raise ArgumentError, "Message Error. Invalid emitter file '#{@config_path}#{@emitter}.emitter'. Check emitter name is correct. Emitter path can also be set throught config_path."   
      end


      raise ArgumentError, "Message Error. Profile '#{@profile}' not found." unless config[@protocol.to_sym][@profile.to_sym]

      begin
        # Creates a new instance of defined protocol
        @protocol_obj = Porteo.const_get( "#{@protocol}_protocol".capitalize.to_sym ).new( config[@protocol.to_sym][@profile.to_sym] )
      rescue NameError
        raise ArgumentError, "Message Error. Undefined protocol. Check if '#{@protocol}_protocol.rb' is created and is valid."
      end

      # Set template values
      @protocol_obj.set_template( @template_content, @template_requires )
      @protocol_obj.set_template_params( @template_params )

      # Set receiver
      @protocol_obj.receiver = @receiver

      # Send the message
      @protocol_obj.send_message
    end

    # Method to see the complete message by sections, once it has been sent.
    # @return [String] the message sections
    def show_message
      @protocol_obj.message unless @protocol_obj == nil
    end

    # Method missing to allow set params one by one.
    # @param [Symbol] method method name called which doesn't exist
    # @param [Array] params params in the call
    # @param [Block] block block code in method
    def method_missing( method, *params, &block )
      # We only allow one param to be passed
      @template_params[method] = params[0]
    end

    private
    # Recover the information defined in a template file. The template is
    # defined using YAML. It has the format of a hash, containing a key named
    # requires, which value is an array of required fields for the template,
    # and a key named template which contain the template itself.
    # @param [String] template Template name to be used. Various templates may
    #   have the same name (alert.mail, alert.sms, alert.twitter) but the one
    #   named as protocol used will be used. So template name it just the first
    #   part of the template filename.
    # @return [nil]
    def load_template( template )
      begin
        content = YAML.load_file( "#{@template_path}#{template}.#{@protocol}" )
      rescue Errno::ENOENT
        raise ArgumentError, "Message Error. Invalid template file '#{@template_path}#{template}.#{@protocol}'. Check if template name is correct and you are using a valid protocol. Template path can also be set throught template_path."
      end
      
      if( content )
        @template_content = content[:template].to_s
        @template_requires = content[:requires]
      end

    end
  end

end
