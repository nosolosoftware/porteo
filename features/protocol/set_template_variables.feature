Feature: Set template variable
  As a Message sender
  I want to set the variables of the template file
  In order to Send the message correctly with different variables and the same template

  Scenario: set a template variables
    Given I have a template
    And I have a protocol
    When I set the variables of the template
    Then the protocol should respond to the variables
