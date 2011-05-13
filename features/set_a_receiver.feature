Feature: Set a receiver to send a message
  As a user
  I want to set a receiver
  In order to be capable of send a message

  Scenario: Set a receiver
    Given a new message
    When I set "account@domain.com" as receiver of that message
    Then message should contain the "account@domain.com" receiver
