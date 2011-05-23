require './src/lib/protocols/protocol'

module Porteo

  class Mail_protocol < Protocol
    MAIL_REQUIRED_FIELDS = [:to, :body]
    
    def override_tags
      # In mail protocol, the receiver instance variable has precedence over
      # :to tag in template
      @message_sections[:to] = @receiver unless @receiver == nil
    end
    
    def check_message_sections
      raise ArgumentError, "There are no template sections. Maybe you didn't load a complete template" unless @message_sections != nil

      # Check for required fields
      MAIL_REQUIRED_FIELDS.each do |field|
        raise ArgumentError, "#{field.to_s.capitalize} is a required field for this protocol and it was not defined" unless @message_sections[field] != nil
      end

      # Check for correct syntax
      if not @message_sections[:to] =~ /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/
        raise ArgumentError, "Bad syntax in :to section"
      end

    end
  end

end
