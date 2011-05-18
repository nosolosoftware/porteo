require 'erb'

module Porteo
  # Parent class wich represent the common funtionality to all prtocols
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
    end

    # @param template [Hash] The template per se
    # @param requires [Array] the requires of the template
    def set_template( template, requires )
      # parse the template with ERB
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
      # should call expand_message
      expand_message.to_s
    end

    def send_message
      @gateway = Porteo.const_get( @gw_config[:gateway].to_s.capitalize.to_sym ).new
      @gateway.send_message( expand_message )
    end

    # Private methods
    private

    # Should expand the message from template and variables
    def expand_message

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


