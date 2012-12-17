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

# Porteo is an integrated message sending service.
# It allows you to send messages by various protocols (sms, email, twitter)
# using differents gateways (mensario, pony, twitter API). You can also
# integrate new protocols and gateways for your favorite messenger
# service.
module Porteo

  # Base class to implement any gateway needed to connect protocols
  # and sending service gems.
  #
  # It should not be used by itself but creating a child class which
  # defines specific behavior based on a certain protocol and a gem.
  class Gateway

    # Set required connection parameters for a specific gateway.
    # This class method creates a new instance method which overwritte
    # connection_argument.
    # @param [Array] argument Required connection arguments.
    # @return [nil]
    def self.connection_argument( *argument )
      define_method( :connection_arguments ) do
        argument
      end
    end

    # Required connection parameters.
    # Its define which fields have to be present in order to
    # send a valid message.
    # This method is overwritten dynamically when a child gateway
    # class is created and self.connection_arguments is called.
    # @return [Array] Required connection parameters.
    def connection_arguments
      []
    end

    # Create a new instance of a gateway.
    # @param [Hash] gw_config Configuration options. This options
    #   set the sending parameters not the content of the message.
    def initialize( gw_config = {} )
      @config = gw_config
    end

    # @abstract
    # Send a message defined in parameter
    # @param [Hash] message_sections Message content.
    # @return [nil]
    # @raise [Exception] This method is not meant to be call but to be overwritten.
    # @note This method has to be overwritten.
    def send_message( message_sections )
      raise Exception, "Gateway Error. This method has to be overwritten. You are trying to send a message with a generic gateway."
    end

    # Initialize the send message process.
    # Before sending the message it check if all required params are present.
    # @param [Hash] message Message sections to be sent.
    # @return [nil]
    def init_send( message )
      send_message_hook( message )
    end

    # PRIVATE METHODS
    private

    # Defines send message process.
    # It first look for all required connection arguments
    # and then it send the message.
    # @param [Hash] message Message section to be sent.
    def send_message_hook( message )
      check_connection_arguments
      send_message( message )
    end

    # Looks for a key in a specified hash.
    # If an argument is not present, an ArgumentError is raised.
    # @param [Hash] config Configuration hash.
    # @param [Symbol] argument Key that should be contain by hash.
    # @return [nil]
    # @raise [ArgumentError] If the argument is not present in configuration hash.
    def check_argument( config, argument )
      raise ArgumentError, "Gateway Error. Too few arguments to connect." unless config[argument] != nil
    end

    # Checks the required connection parameters to any gateway.
    # Those parameters are defined by class method connection_argument.
    # @return [nil]
    def check_connection_arguments
      # Iterate over arguments
      connection_arguments.each do |argument|

        # If argument is a hash, we need to search for the parameter
        # in a sublevel of config. That sublevel is defined by the hash
        # key so there should be only one key. The value of that key is an
        # array containing the sublevel arguments.
        if argument.class == Hash
          argument.values[0].each do |value|

            # Once we know where and what look for, we do the check
            check_argument( @config[argument.keys[0]], value )
          end
        else

          # Check the argument in top level configuration array.
          check_argument( @config, argument )
        end

      end
    end
  end
end
