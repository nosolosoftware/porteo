Feature: Recover send information from emitter file to send a message 
  As a user 
  I want to store the send configuration data in a file
  So I can send a message using data loaded in this file

  Scenario: Emitter file is valid
    Given a file called "nosolosoftware.emitter"
    And a protocol "mail"
    And a sending profile "admin"
    When I create a message from a emitter file, protocol and profile
    Then message should contain the data stored in emitter file 
