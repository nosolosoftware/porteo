# Copyright 2011 NoSoloSoftware
#
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

require 'twitter'
require 'gateways/gateway'

# Porteo is an integrated message sending service.
# It allows you to send messages by various protocols (sms, email, twitter)
# using differents gateways (mensario, pony, twitter API). You can also
# integrate new protocols and gateways for your favorite messenger
# service.
module Porteo

  # Gateway to use Twitter service with Twitter gem.
  # In Porteo this class acts as a link between any twitter protocol
  # and Twitter gem.
  #
  # This class inherits from Gateway and just overwrite
  # the send_message method.
  class Twitter_gateway < Gateway

    connection_argument :consumer_key,
                        :consumer_secret,
                        :oauth_token,
                        :oauth_token_secret

    # Send the twitt using Twitter gem.
    # @param [Hash] msg The message sections to send
    # @return [nil]
    def send_message( msg )
      Twitter.configure do |config|
        config.consumer_key = @config[:consumer_key]
        config.consumer_secret = @config[:consumer_secret]
        config.oauth_token = @config[:oauth_token]
        config.oauth_token_secret = @config[:oauth_token_secret]
      end

     Twitter.update( msg[:body] )
    end
  end

end

