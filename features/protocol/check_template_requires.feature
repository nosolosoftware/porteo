Feature: Check the template requires
  As a user who use a template
  I want to specify obligatory params
  in order to be able to define a complete message

  Scenario: All required params aren't present
    Given I have a template "examples_helpers/good_formatted.protocol"
    And I have a protocol "Protocol"
    And I have params "{:nombre => 'Pepitilla'}"
    When I set the template
    Then The protocol shouldn't respond to the variables
