@local @local_adele @javascript

Feature: As an admin I create stacked adele learning path.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname    | email                       |
      | user     | Username  | Test        | toolgenerator1@example.com  |
      | teacher  | Teacher   | Test        | toolgenerator3@example.com  |
      | manager  | Manager   | Test        | toolgenerator4@example.com  |
    And the following "courses" exist:
      | fullname | shortname | summary     |
      | Course 1 | C1        | LP Course 1 |
      | Course 2 | C2        | LP Course 2 |
      | Course 3 | C3        | LP Course 3 |
      | Course 4 | C4        | LP Course 4 |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | user     | C1     | student        |
      | teacher  | C1     | editingteacher |
    And the following config values are set as admin:
      | config            | value                                                      | plugin      |
      | restrictionfilter | timed,timed_duration,specific_course,parent_courses,manual | local_adele |
    And I change viewport size to "1666x6000"

  @javascript
  Scenario: Adele usage: admin create a new stacked learning path
    Given I log in as "admin"
    And I click on "Learning Paths" "button" in the "#usernavigation" "css_element"
    And I click on "Add a new learning path" "button"
    And I set the field "goalnameplaceholder" to "Stacked Learning Path"
    And I set the field "goalsubjectplaceholder" to "Stacked Learning Path Description"
    ##And I click on "Select learning path image" "button"
    ##And I click on ".image-selection-container .image-option-img" "css_element"
    ## Create learning part in visual way.
    And I wait "1" seconds
    And I drag and drop HTML5 from ".learning-path-nodes-container .nodes > :nth-child(1)" to "[data-id='starting_node']"
    And I click on "[data-id='dndnode_1'] .card-header" "css_element"
    And I wait "1" seconds
    And I drag and drop HTML5 from ".learning-path-nodes-container .nodes > :nth-child(2)" to "[data-id='dndnode_1']" as "[data-id='dropzone_or']"
    And I click on "[data-id='dndnode_1'] .card-header" "css_element"
    And I wait "1" seconds
    And I drag and drop HTML5 from ".learning-path-nodes-container .nodes > :nth-child(3)" to "[data-id='dndnode_1']" as "[data-id='dropzone_or']"
    And I click on "[data-id='dndnode_1'] .card-header" "css_element"
    And I wait "1" seconds
    And I drag and drop HTML5 from ".learning-path-nodes-container .nodes > :nth-child(4)" to "[data-id='dndnode_1']" as "[data-id='dropzone_child']"
    ## Manually add completion to the parent nodes.
    And I click on "[data-id='dndnode_1'] .icon-link .fa-tasks" "css_element"
    And I wait "1" seconds
    And I set the field "completion-condition_1-min" to "2"
    And I click on "Save" "button" in the ".vue-flow__panel.save-restore-controls" "css_element"
    ## Save entire learning path and validate its root elements - nodes and connections.
    And I click on "Save" "button" in the ".vue-flow__panel.save-restore-controls" "css_element"
    And I should see "Stacked Learning Path" in the ".learningcardcont .learningcard" "css_element"
