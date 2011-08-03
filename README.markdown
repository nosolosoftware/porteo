# Porteo
A Ruby gem that send messages via any protocol/gateway with programable templates and emitters.

# Usage
All you have to do is to create a new Message object like this:

    my_msg = Porteo::Message.new()

    my_msg.configure do |m|
      # set the template named foo
      # The template must be set in the template path (./config/templates/ by default)
      m.template = "foo"
      # set the emitter named bar
      # The emitter must be set in config path (./config/ by default)
      # by default get the "default" profile in emitter
      m.emitter = "bar"
      # Set the protocol
      m.protocol = "desired_protocol"
    end

Now you only have to set the params on the template (if you required it) like this:

    my_msg.set_template_params = { :name_of_the_param => value_of_the_param }

Or this:
    
    my_msg.name_of_the_param = value_of_the_param

# Configuration Files
The files that are strictly necesaries are: a emitter, and a template. Their construction are the folloing:

## Emitter
An emitter must be constructed using YAML like this:

    :protocolName:
      :profileName:
        :configParam1: :valueParamSymbol
        :configParamFoo: 'valueParamString'
        :configParambar: 'etc'
      :otherProfile:
        :configParam: :value
        :bar: 'foo'
    :otherProtocol:
      :profileName:
        :protocolconfigparam: 'value'

## Template
A template file must be constructed using YAML + ERB like this:

    :requires: [:parameterName]
    :template:
      :fieldOfTemplate: "This is a Example of a template file, a parameter must be given, its value is: <%= param[:parameterName] %>"

The template file must be named with "templateName.protocolName", ONLY templateName must be given to the Message class to know which template to use.

# About
Porteo is developed by [NoSoloSoftware](http://nosolosoftware.biz).

# License
Porteo is Copyright 2011 NoSoloSoftware, it is free software.

Porteo is distributed under GPLv3 license. More details can be found at COPYING file.

