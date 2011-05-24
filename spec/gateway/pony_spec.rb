require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'yaml'
describe Pony_gateway do
  # Check that pony respond to all methods
  it "should respond to all methods that are in the parent class" do
    Pony_gateway.new({}).should respond_to( :send_message )
  end

  # Check etc...
  it "should send a mail" do

    # For a security reason, we load the config from a file
    config = YAML.load_file('./examples_helpers/config/clave.emitter')
    my_gw = Porteo::Pony_gateway.new(config[:mail][:default])

    # We set the hash of the mail
    mail = {}
    mail[:to] = 'info@nosolosoftware.biz'
    mail[:subject] = 'Test de correo!'
    mail[:from] = 'Marditos_Bastardos@nosolosoftware.biz'
    mail[:body] = 'Yuhuuuu!'

    my_gw.send_message( mail )
  end
end

