Feature: Pretty Compact

  Scenario: Pretty
    Given I run jq on "people.json"
    When I type "{age: .age}"
    And I press "C-c C-p"
    Then I should see jq output:
      """
      {
        "age": 32
      }
      {
        "age": 16
      }
      {
        "age": 43
      }
      {
        "age": 27
      }
      {
        "age": 16
      }
      {
        "age": 48
      }
      {
        "age": 36
      }
      {
        "age": 68
      }
      """

  Scenario: Compact
    Given I run jq on "people.json"
    When I type "{age: .age}"
    Then I should see jq output:
      """
      {"age":32}
      {"age":16}
      {"age":43}
      {"age":27}
      {"age":16}
      {"age":48}
      {"age":36}
      {"age":68}
      """
