module Porteo
  # Parent class wich represent the common funtionality to all prtocols
  class Protocol
   
    # @param [Hash] Configuration of the gateway
    def initialize( param )
      # Create the gateway
      # @todo requires the gateway to avoid multiple requires
      # @gateway = Porteo.const_get( param[:gateway].to_s.capitalize.to_sym ).new
      @param = {}
      @template = {}
    end

    # @param template [Hash] The template per se
    # @param requires [Array] the requires of the template
    def set_template( template, requires )
      # parse the template with ERB
      @template = template
    end
    
    def set_template_params( params )
      @param = params
    end

    def message
      # should call expand_message
      expand_message(@param)
    end


    # Private methods
    private

    # Should expand the message from template and variables
    def expand_message(param)
      # 
      erb_template = ERB.new( @template, 0, "%<>" )

      result = erb_template.result
    end
  end
end


