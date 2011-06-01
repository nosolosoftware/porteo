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

require 'erb'

module Porteo
  
  # Base class to implement common funcionality for all protocols.
  #
  # In Porteo system, the protocol creates an appropiate gateway to
  # send the message through it.
  class Protocol
    
    # Who the message is going to be sent to
    attr_accessor :receiver
    # Hash with that contain gateway configuration parameters
    attr_accessor :gw_config

    # Creates a new instance of a  protocol
    # @param [Hash] Gateway configuration parameters.
    def initialize( gw_config )
      # Initilization
      @gw_config = gw_config

      @param = {}
      @template = ""
      @requires = []

      @message_sections = []

      @receiver = nil
    end

    # Set the template to be used.
    # @param [Hash] template The template per se.
    # @param [Array] requires The requires of the template. Which is the
    #   required fields for this template. Those required fields has to be
    #   present in the template parameters or an error will be raised.
    # @return [nil]
    def set_template( template, requires )
      @template = template
      @requires = requires
    end
    
    # Set the values of template parameters
    # @param [Hash] param Pairs of required fields for the template and
    #   the value its take.
    # @return [nil]
    def set_template_params( param )
      @param = param
    end

    # The raw message sections hash to be sent.
    # @return [String] Message sections which will be sent. This method
    #   returns the message as a string containing every section of the message
    #   already parsed.
    # @note As sections can be dynamic (because of ERB preprocessing) this method
    # may not show some sections present in a template, depending on the parameters
    # passed.
    def message
      # Call to expand_template
      expand_template.to_s
    end

    # Send the message defined by template and template parameters. It used
    # the gateway configuration options to send the message through a third-party
    # ruby gem.
    # @return [nil]
    def send_message
      # Expand the template, here we also check if template is well-formatted
      @message_sections = expand_template

      # As we can define instance variables with highest priority than template 
      # tags, we may want to override those tags for a certain protocol
      override_tags

      # Check if a well-formatted template contains all fields necessaries
      # to send this kind of message.
      check_message_sections
      
      require "./src/lib/gateways/#{@gw_config[:gateway]}_gateway"

      # Create the appropiate gateway, which is defined in gw_config
      @gateway = Porteo.const_get( "#{@gw_config[:gateway]}_gateway".capitalize.to_sym ).new( @gw_config )
      
      # Send the message
      @gateway.init_send( @message_sections )
    end

    
    # Private methods
    private

    # @abstract
    # Check for all required sections to be defined.
    # @return [nil]
    # @note This method has to be overwritten.
    def check_message_sections
      raise Exception, "This method has to be overwritten. You are trying to check for required sections in a generic protocol."
    end

    # @abstract
    # Allow programmers to change the order precedence.
    # @note If you want to change the value of any template tag, you should
    # do it here.
    def override_tags
    end

    # Expand the message from template and variables.
    # A template is a collection of sections which define the content
    # of a message, but those sections are dynamic thanks to the use
    # of ERB code. At the same time, the parameters are filled with
    # it value.
    # @return [nil]
    def expand_template
      # Check for existence of required parameters
      @requires.each do |required_param|
        raise ArgumentError if @param[required_param] == nil
      end

      param = @param

      erb_template = ERB.new( @template, 0, "%<>" )

      # Binding get the execution context to allow the use of
      # param in the template
      template_filled = erb_template.result( binding )

      # We use eval to get a Hash with message sections because
      # erb return a string
      # [:body] => "..."
      # [:attachments] => "..."
      # ...
      eval( template_filled )
    end
  end

end


