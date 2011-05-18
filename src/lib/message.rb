module Porteo
  
  class Message
    attr_reader :template, :template_requires
    attr_reader :protocol_name

    attr_accessor :template_params
    attr_accessor :config_path, :template_path
    attr_accessor :receiver, :profile, :emitter


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

      @receiver = ""

      # Assign instance variables
      @emitter = emitter
      @profile = profile
      @protocol_name = protocol.to_s
    end

    def set_template_params( params )
      @template_params = params 
    end

    def load_template( template )
      config = YAML.load_file( "#{@template_path}#{template}.#{@protocol_name}" )

      @template =  config[:template].to_s
      @template_require = config[:requires]
    end
    
    def send_message
      config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )

      @protocol = Porteo.const_get( @protocol_name.to_s.capitalize.to_sym ).new( config[@protocol_name.to_sym][@profile.to_sym] )

      @protocol.set_template( @template, @template_requires )
      @protocol.set_template_params( @template_params )

      @protocol.receiver = @receiver

      @protocol.send_message
    end
  end

end
