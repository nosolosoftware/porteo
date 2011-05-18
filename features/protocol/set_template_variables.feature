Feature: Set template variable
  As a Message sender
  I want to set the variables of the template file
  In order to Send the message correctly with different variables and the same template

  Scenario: set a template variables
    Given I have a template "examples_helpers/good_formatted.protocol"
    And I have a protocol "Protocol"
    And I have params "{:nombre => 'Paco', :apellido => 'Mermela'}"
    When I set the template
    Then the protocol should respond to the variables "{:head => 'Bienvenido a Porteo, Paco', :body => 'Estimado señor Mermela, es mi deber darle la bienvenida al maravilloso mundo de: PORTEO', :tail => 'Un cordial saludo'}"
