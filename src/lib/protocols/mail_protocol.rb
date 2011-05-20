require './src/lib/protocols/protocol'

module Porteo

  class Mail_protocol < Protocol
    MAIL_REQUIRED_FIELDS = [:body]

    def check_message_sections
      MAIL_REQUIRED_FIELDS.each do |field|
        raise ArgumentError, "#{field.to_s.capitalize} is a required field for this protocol and it was not defined" unless @message_sections[field] != nil
      end

    end
  end

end
