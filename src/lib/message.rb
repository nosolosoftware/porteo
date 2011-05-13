module Porteo
  
  class Message
    attr_reader :gateway

    def initialize( emitter, protocol, profile, opts = [] )
      # config_path value should end in a trailing slash
      opts[:config_path] ||= "./config/"
      @config_path = opts[:config_path]

      @emitter = emitter

      @config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )[protocol]

      @gateway = Porteo.const_get( @config[profile][:gateway].to_s.capitalize.to_sym ).new( @config[profile] )
    end
  end

end
