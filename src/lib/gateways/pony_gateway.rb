# Copyright 2011 NoSoloSoftware

# This file is part of Porteo.
# 
# Porteo is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Porteo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Porteo. If not, see <http://www.gnu.org/licenses/>.

require './src/lib/gateways/gateway'
require 'pony'

module Porteo
 
  # Gateway to use an email service with Pony gems.
  # In Porteo system, this class acts as a link between any email 
  # protocol and Pony gem.
  #
  # This class inherits from Gateway class and just overwrite 
  # the method send_message.
  class Pony_gateway < Gateway
    
    connection_argument :address, 
                        :port 
    connection_argument :user_name, 
                        :password

    # Options allowed for Pony API.
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

    # Via configuration options.
    # The sending method is configured with these options.
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
    
    # Send the message defined in parameter.
    # @param [Hash] message_sections Differents parts of message. Allowed keys
    #   are defined in PONY_OPTIONS.
    # @return [nil]
    def send_message( message_sections )
      # Create options hash to Pony
      pony_config = {}

      # Recover data from template
      # We look for each option defined before in the message content
      PONY_OPTIONS.each do |opt|
        pony_config[opt] = message_sections[opt] if message_sections[opt] != nil
      end

      # Recover data from send options
      # First we get the via used to send the message
      pony_config[:via] = @config[:via]

      # Then we look for the other configuration options      
      pony_config[:via_options] = {}
      VIA_OPTIONS.each do |opt|
        pony_config[:via_options][opt] = @config[:via_options][opt] if @config[:via_options][opt] != nil
      end

      # Send the message
      Pony.mail( pony_config )
    end
  end

end
