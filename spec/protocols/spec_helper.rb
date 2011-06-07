$LOAD_PATH << File.expand_path( '../../../src/lib/protocols/', __FILE__ )
$LOAD_PATH << File.expand_path( '../../../src/lib/gateways/', __FILE__ )
require 'protocol'
require 'mail_protocol'
require 'gateway'
require 'pony_gateway'
require 'sms_protocol'
require 'mensario_gateway'

include Porteo

