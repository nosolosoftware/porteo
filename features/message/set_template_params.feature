Feature: Set the template params 
  As a user of porteo
  i want to set the template params
  in order to complete the template easily

  Scenario: Set the template params
    Given a new message
    When I set template to "small"
    And I set the template path "examples_helpers/config/templates/"
    And I set the config path "examples_helpers/config/"
    And I set the param "nombre" with argument "Paco"
    And I set the param "repeticiones" with argument "5"
    And I send a message
    Then Complete template should be "Nombre: Paco, Repeticiones: 5"
