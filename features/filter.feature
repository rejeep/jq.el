Feature: Filter

  Scenario: Single property
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

  Scenario: Array
    Given I run jq on "people.json"
    When I type "[.name, .age]"
    Then I should see jq output:
      """
      ["John",32]
      ["Peter",16]
      ["Anna",43]
      ["Karen",27]
      ["Jess",16]
      ["Doug",48]
      ["Sandy",36]
      ["Carl",68]
      """

  Scenario: Object
    Given I run jq on "people.json"
    When I type "{n: .name, a: .age}"
    Then I should see jq output:
      """
      {"n":"John","a":32}
      {"n":"Peter","a":16}
      {"n":"Anna","a":43}
      {"n":"Karen","a":27}
      {"n":"Jess","a":16}
      {"n":"Doug","a":48}
      {"n":"Sandy","a":36}
      {"n":"Carl","a":68}
      """

  Scenario: Replace filter
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
    When I press "C-u 5 <backspace>"
    And I type ".age"
    Then I should see jq output:
      """
      32
      16
      43
      27
      16
      48
      36
      68
      """
