Feature: Recover send information from emitter file to send a message 
  As a user who want to send a message from a desired "emitter"
  I want to recover the emitter options from a file
  So I can get all the options to send the message

  Scenario: Load information from emitter file
    Given a emitter "nosolosoftware"
    And a protocol "mail"
    And a profile "admin"
    When I create a new message by emitter, protocol and profile
    Then emitter should be "nosolosoftware" 
    And protocol should be "mail"
    And profile should be "admin"
    And configuration path should be "./src/config/"
    And receiver should be empty
    And template params should not been initialized
