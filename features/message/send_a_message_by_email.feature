Feature: Send a message by email 
  As a user
  I want to send a message by email
  In order to comunicate with other people or mail service

  Scenario: Send a message by email
    Given a message created using "mail" protocol
    When I send a message
    Then message should have been received at "receiver"

  Scenario: Send a message by email with some file attach
    Given a new email message
    And the template "attach"
    And the file "examples_helpers/attach.txt"
    When I send the message
    Then the message should arrive with the attachment file "examples_helpers/attach.txt"

