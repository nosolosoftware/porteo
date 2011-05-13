module Porteo
  
  class Message
    attr_reader :gateway, :protocol
    attr_reader :gateway_name, :protocol_name
    attr_reader :template, :template_params, :template_file
    attr_reader :config_path, :template_path
    
    attr_accessor :receiver

    def initialize( emitter, protocol, profile, opts = {} )
      # config_path value should end in a trailing slash
      opts[:config_path] ||= "./config/"
      @config_path = opts[:config_path]

      # template_path value should end in a trailing slash
      opts[:template_path] ||= "./config/templates/"
      @template_path = opts[:template_path] 
      
      # Instance variables initilization
      @template_file = ""
      @template_params = {}
      @template = {}
      @receiver = ""

      # Assign instance variables
      @emitter = emitter
      @profile = profile

      # Load configuration information
      @config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )[protocol]

      @protocol = Porteo.const_get( protocol.to_s.capitalize.to_sym ).new

      @gateway = Porteo.const_get( @config[@profile][:gateway].to_s.capitalize.to_sym ).new( @config[@profile] )

      @protocol_name = protocol.to_s
      @gateway_name = @config[@profile][:gateway].to_s
    end

    def set_template( template )
      @template_file = "#{@template_path}#{template}.#{@protocol_name}"
      
      #@template_params = YAML.load_file("#{@template_path}#{@template_file}.#{@protocol}" )[:requires]
      #@template = YAML.load_file("#{@template_path}#{@template_file}.#{@protocol}" )[:template]
      @protocol.set_template( @template_file )
    end

    def set_template_params( params )
      @protocol.set_template_params( params )
    end

    def send
    end
  end

end
