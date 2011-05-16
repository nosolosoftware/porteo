module Porteo
  
  class Message
    attr_reader :template, :template_requires, :template_file
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
      @template_file = ""
      @template_params = {}
      @template = ""
      @template_requires = {}

      @receiver = ""

      # Assign instance variables
      @emitter = emitter
      @profile = profile
      @protocol_name = protocol.to_s
    end

    def expand_template( template )
      @template_file = "#{@template_path}#{template}.#{@protocol_name}" 
    end

    def set_template_params( params )
      @template_params = params 
    end

    def load_template
      # We should raise an exception if template_file have not been set.
      template =  YAML.load_file( "#{@template_path}#{@template_file}.#{@protocol_name}" )  
      
      @template = template[:template]   
      @template_requires = template[:requires]   
    end

    def set_receiver( receiver )
      @receiver = receiver
    end
    
    def send_message
      config = YAML.load_file( "#{@config_path}#{@emitter}.emitter" )

      @protocol = Porteo.const_get( @protocol_name.to_s.capitalize.to_sym ).new( config[@protocol_name.to_sym][@profile.to_sym] )

      @protocol.set_template( @template, @template_requires )
      @protocol.set_template_params( @template_params )

      @protocol.send_message
    end
  end

end
