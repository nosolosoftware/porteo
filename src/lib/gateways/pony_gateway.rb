require './src/lib/gateways/gateway'
require 'pony'

module Porteo

  class Pony_gateway < Gateway
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

      # Recover data from template
      PONY_OPTIONS.each do |opt|
        pony_config[opt] = message_sections[opt] if message_sections[opt] != nil
      end

      pony_config[:via] = @config[:via]
      pony_config[:via_options] = {}
      VIA_OPTIONS.each do |opt|
        pony_config[:via_options][opt] = @config[:via_options][opt] if @config[:via_options][opt] != nil
      end

      Pony.mail( pony_config )
    end
  end

end
