Feature: Send Message
  As a user
  i want to send a message
  in order to comunicate something

  Scenario: Send message
    Given I have a template "examples_helpers/good_formatted.protocol"
    And I have a protocol "Protocol"
    And I have params "{:nombre => 'Paco', :apellido => 'Mermela'}"
    And Protocol params "{ :gateway => 'Gateway' }"
    When I send the message
    Then The message should have been received at "receiver"
