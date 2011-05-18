$LOAD_PATH << File.expand_path('../../../src/lib/', __FILE__)
$LOAD_PATH << File.expand_path('../../../src/lib/gateways/', __FILE__)
$LOAD_PATH << File.expand_path('../../../src/lib/protocols/', __FILE__)
$LOAD_PATH << File.expand_path('../../../examples_helpers/', __FILE__)
 
require 'message'
require 'gateways/gateway'
require 'gateways/pony'
require 'protocols/protocol'
require 'protocols/mail'
