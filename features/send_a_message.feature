Feature: Send a message by any protocol
  As a user
  I want to send a message
  In order to comunicate with another people or service

  Scenario: Send a message by email
    Given a message created using "mail" protocol
    When I send a message
    Then message should have been received at "receiver"
