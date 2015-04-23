Feature: Pretty Raw

  Scenario: Raw
    Given I run jq on "people.json"
    When I type ".name"
    And I press "C-c C-r"
    Then I should see jq output:
      """
      John
      Peter
      Anna
      Karen
      Jess
      Doug
      Sandy
      Carl
      """

  Scenario: Cooked
    Given I run jq on "people.json"
    When I type ".name"
    Then I should see jq output:
      """
      "John"
      "Peter"
      "Anna"
      "Karen"
      "Jess"
      "Doug"
      "Sandy"
      "Carl"
      """
