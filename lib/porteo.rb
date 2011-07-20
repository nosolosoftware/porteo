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

require 'message/message'

# Porteo is an integrated message sending service.
# It allows you to send messages by various protocols (sms, email, twitter)
# using differents gateways (mensario, pony, twitter API). You can also
# integrate new protocols and gateways for your favorite messenger 
# service.
module Porteo
  # Default configuration path 
  CONFIG_ROOT = "./config/"
  # Default templates path
  TEMPLATES_ROOT = "./config/templates/"
  # Default locales path
  LOCALES_ROOT = "./config/locales/"

  YAML::ENGINE.yamler = 'syck'
end
