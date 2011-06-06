Feature: Send a message by sms
  As a user
  I want to send a sms message
  In order to comunicate with other people

  Scenario: Send a message by sms using gateway mensario
    Given a new sms message
    When I send the message
    Then message should have been received at "receiver"
