require 'pony'

module Porteo

  class Pony < Gateway
    PONY_OPTIONS = [ 
      :to, 
      :cc, 
      :bcc, 
      :from, 
      :body, 
      :html_body, 
      :subject, 
      :charset,
      :attachments,
      :headers,
      :message_id,
      :sender
      ]

    VIA_OPTIONS = [
      :address, 
      :port, 
      :user_name, 
      :password, 
      :enable_starttls_auto,
      :authentication,
      :domain,
      :location,
      :argument
      ]

    def send_message( message_sections )
      # Create options hash to Pony
      pony_config = {}

      PONY_OPTIONS.each do |opt|
        pony_config[:opt] = message_sections[:opt] if message_sections != nil
      end

      pony_config[:via] = @config[:via]
      VIA_OPTIONS.each do |opt|
        pony_via_options[:via_options][:opt] = @config[:via_options][:opt] if @config != nil
      end

      # Required params not included in the emitter
      # If a parameters is defined in emitter and in
      # message sections, emitter has priority
      pony_config[:body] ||= message_sections[:body]
      pony_config[:to] ||= message_sections[:to]
      pony_config[:from] ||= message_sections[:from]

      Pony.mail( pony_config )
    end
  end

end
