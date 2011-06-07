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

require './src/lib/protocols/protocol'

module Porteo

  # Implementation of email protocol to be used in Porteo system.
  # It only define specific behavior for this protocol.
  class Mail_protocol < Protocol

    # Necessary fields to send a valid email
    MAIL_REQUIRED_FIELDS = [:to, :body]
    
    # Implementates the parent method to ensure that email receptor is 
    # the one set at receiver instance variable not the :to template tag
    # @return [nil]
    def override_tags
      # In mail protocol, the receiver instance variable has precedence over
      # :to tag in template
      @message_sections[:to] = @receiver unless @receiver == nil
    end
    
    # Check for all required field to exist and contain valid values.
    # If any required field is missing or its syntax is not valid 
    # an ArgumentException is raised.
    # @return [nil]
    # @raise [ArgumentError] When no template sections are present
    #   or no required parameter is given.
    def check_message_sections
      raise ArgumentError, "Protocol Error. There are no template sections. Maybe you didn't load a complete template" unless @message_sections != nil

      # Check for required fields
      MAIL_REQUIRED_FIELDS.each do |field|
        raise ArgumentError, "Protocol Error. #{field.to_s.capitalize} is a required field for this protocol and it was not defined" unless @message_sections[field] != nil
      end

      # Check for correct syntax
      if not @message_sections[:to] =~ /[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/
        raise ArgumentError, "Protocol Error. Bad syntax in :to section"
      end
    end
  end

end
