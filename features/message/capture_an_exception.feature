Feature: Capture an exception
  As a user
  I want to capture exception
  In order to not finish the application if made a mistake

  Scenario: Too few parameters in emitter file
    Given a emitter "few-parameters"
    And a protocol "twitter"
    And a profile "default"
    When I create a new message using too few configuration parameters
    Then I should get an exception if I send the message
