Feature: Recover send information from emitter file to send a message 
  As a user who want to send a message from a desired "emitter"
  I want to recover the emitter options from a file
  So I can get all the options to send the message

  Scenario: Getting correct Information
    Given I want to set "nosolosoftware.emitter" as emitter
    When I create a message with "nosolosftware.emitter" emitter
    Then message should contain the data stored in emitter file 
