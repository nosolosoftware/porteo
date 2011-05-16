Feature: Custom configuration files path
  As a user who needs to send a message
  I want to define my own path to configuration files
  In order to load configuration files from differents locations

  Scenario: Set a custom location
    Given a emitter "nosolosoftware"
    And a protocol "mail"
    And a profile "admin"
    And a configure files location "./src/config/"
    When I create a new message by emitter, protocol, profile and custom location
    Then emitter should be "nosolosoftware" 
    And protocol should be "mail"
    And profile should be "admin"
    And configuration path should be "./src/config/"
    And receiver should be empty
    And template params should not been initialized
