require 'erb'

module Porteo
  # Parent class wich represent the common functionality for all prtocols
  class Protocol
   
    attr_accessor :receiver, :gw_config

    # @param [Hash] Configuration of the gateway
    def initialize( gw_config )
      # Create the gateway
      # @todo requires the gateway to avoid multiple requires
      @gw_config = gw_config

      @param = {}
      @template = ""
      @requires = []

      @message_sections = []

      @receiver = nil
    end

    # @param template [Hash] The template per se
    # @param requires [Array] the requires of the template
    def set_template( template, requires )
      # Parse the template with ERB
      @template = template
      @requires = requires
    end
    
    def set_template_params( param )
      @param = param
    end

    # Show the raw message sections to be sent.
    # Childrens should overwrite this method to format the message
    # properly.
    def message
      # Call expand_template
      expand_template.to_s
    end

    def send_message
      # Expand the template,here we also check if template is well-formatted
      @message_sections = expand_template

      # As we can define instance variables with highest priority than template 
      # tags, we may want to override those tags for a certain protocol
      override_tags

      # Check if a well-formatted template contains all fields necessaries
      # to send this kind of message.
      #
      # This method has to be defined in child classes
      check_message_sections

      @gateway = Porteo.const_get( "#{@gw_config[:gateway]}_gateway".capitalize.to_sym ).new( @gw_config )
      @gateway.send_message( @message_sections )
    end

    
    # Private methods
    private

    def check_message_sections
      raise Exception, "YOU MUST DEFINE THIS METHOD ^_^U"
    end

    def override_tags
    end

    # Should expand the message from template and variables
    def expand_template
      # check required parameters
      @requires.each do |required_param|
        raise ArgumentError if @param[required_param] == nil
      end

      param = @param

      erb_template = ERB.new( @template, 0, "%<>" )

      # Binding get the execution context to allow the use of
      # param in the template
      template_filled = erb_template.result( binding )

      # We use YAML to get a Hash with message sections
      # [:body] => "..."
      # [:attachments] => "..."
      # ...
      eval( template_filled )
    end
  end

end


