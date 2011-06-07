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

require 'protocols/protocol'

# Porteo is an integrated message sending service.
# It allows you to send messages by various protocols (sms, email, twitter)
# using differents gateways (mensario, pony, twitter API). You can also
# integrate new protocols and gateways for your favorite messenger 
# service.
module Porteo

  # Implementation of Twitter protocol to be used in Porteo system.
  # It only define specific behavior for this protocol.
  class Twitter_protocol < Protocol
    # Check for the required fields to exists.
    # @return [nil]
    # @raise [ArgumentError] if message cannot be sent.
    def check_message_sections
      raise ArgumentError, "Protocol Error. There are no body section" if @message_sections[:body] == nil
      # the twitt must be shorter than 140 chars.
      raise ArgumentError, "Protocol Error. The message is too long" if @message_sections[:body].length > 140
    end
  end

end


