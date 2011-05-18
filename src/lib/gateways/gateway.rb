module Porteo

  class Gateway
    def initialize( gw_config = {} )
      @config = gw_config
    end
    
    def send_message( message_hash )
      raise Exception, "YOU MUST DEFINE THIS METHOD ^_^U"
    end
  end

end
