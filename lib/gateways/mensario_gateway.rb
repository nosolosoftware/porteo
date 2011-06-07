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

require 'gateways/gateway'

require 'mensario'

module Porteo

  # Gateway to use Mensario service
  # In Porteo this class acts as a link between SMS protocol
  # and Mensario gem
  #
  # This class inherits from Gateway and just overwrite
  # the send_message method
  class Mensario_gateway < Gateway

    connection_argument :license,
                        :password,
                        :username

    # Send the SMS using Mensario gem
    # @param [Hash] msg The message sections to send
    # @return [nil]
    def send_message( msg )

      Mensario.set_config do
        Mensario.license( @config[:license] )
        Mensario.username( @config[:username] )
        Mensario.password( @config[:password] )
      end
      Mensario.send_message( {:text => msg[:text],
                            :sender => msg[:sender],
                            :code => msg[:code], 
                            :phone => msg[:phone], 
                            :timezone => msg[:timezone],
                            :date => msg[:date] }
                           )

     end
  end

end

