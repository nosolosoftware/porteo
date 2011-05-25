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

module Porteo
 
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
    attr_reader :template
    # An array containing required fields to define the template.
    attr_reader :template_requires
    # The name of the protocol used to send the message.
    attr_reader :protocol_name

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
    def initialize( emitter = "", protocol = "", profile = "", opts = {} )
      # config_path value should end in a trailing slash
      opts[:config_path] ||= "./config/"
      @config_path = opts[:config_path]

      # template_path value should end in a trailing slash
      opts[:template_path] ||= "./config/templates/"
      @template_path = opts[:template_path] 
      
      # Instance variables initilization
      @template_params = {}
      @template = ""
      @template_requires = {}

      @receiver = nil

      # Assign instance variables
      @emitter = emitter
      @profile = profile
      @protocol_name = protocol.to_s
    end

    # Assign values to fields defined in the template.
    # @param [Hash] params The keys are the fields defined in the
    #   template which will be set to the hash value.
    # @return [nil]
    def set_template_params( params )
      @template_params = params 
    end

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
      content = YAML.load_file( "#{@template_path}#{template}.#{@protocol_name}" )

      @template =  content[:template].to_s
      @template_require = content[:requires]
    end
    
    # Send a message using protocol, content and configuration set before.
    # @return [nil]
    def send_message
      # Load configuration information for the gateway
      config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )

      # Creates a new instance of defined protocol
      @protocol = Porteo.const_get( "#{@protocol_name}_protocol".capitalize.to_sym ).new( config[@protocol_name.to_sym][@profile.to_sym] )

      # Set template values
      @protocol.set_template( @template, @template_requires )
      @protocol.set_template_params( @template_params )

      # Set receiver
      @protocol.receiver = @receiver

      # Send the message
      @protocol.send_message
    end
  end

end
