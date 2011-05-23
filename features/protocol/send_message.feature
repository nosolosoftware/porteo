Feature: Send Message
  As a user
  i want to send a message
  in order to comunicate something

  Scenario: Send message
    Given I have a template "examples_helpers/config/templates/good_formatted.mail"
    And I have a protocol "Mail_protocol"
    And I have params "{:nombre => 'Paco', :apellido => 'Mermela'}"
    And Protocol params defined in "clave.emitter"
    When I set the template
    And I send the message
    Then The message should have been received at "receiver"
