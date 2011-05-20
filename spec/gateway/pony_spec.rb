require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'yaml'
describe Pony do
  # Check that pony respond to all methods
  it "should respond to all methods that are in the parent class" do
    Pony.new({}).should respond_to( :send_message )
  end

  # Check etc...
  it "should send a mail" do

puts `pwd`
    # For a security reason, we load the config from a file
    config = YAML.load_file('./examples_helpers/config/clave.emitter')
puts config
    my_gw = Porteo::Pony.new(config[:mail][:default])

    # We set the hash of the mail
    mail = {}
    mail[:to] = 'info@nosolosoftware.biz'
    mail[:subject] = 'Test de correo!'
    mail[:from] = 'Marditos_Bastardos@nosolosoftware.biz'
    mail[:body] = 'Yuhuuuu!'

    my_gw.send_message( mail )
  end
end

