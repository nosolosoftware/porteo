require './src/lib/protocols/protocol'

module Porteo
  class Twitter_protocol < Protocol
    def check_message_sections
      raise ArgumentError, "There are no body section" if @message_sections[:body] == nil

      raise ArgumentError, "The message is too long" if @message_sections[:body].length > 140
    end

  end

end


