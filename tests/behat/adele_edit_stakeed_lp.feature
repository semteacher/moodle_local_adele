@local @local_adele @javascript

Feature: As an admin I perform editing of the adele learning path with staked node.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname    | email                       |
      | student  | Student   | Test        | toolgenerator1@example.com  |
      | teacher  | Teacher   | Test        | toolgenerator3@example.com  |
      | manager  | Manager   | Test        | toolgenerator4@example.com  |
    And the following "courses" exist:
      | fullname | shortname | summary |
      | Course 1 | C1        | LP Course 1 |
      | Course 2 | C2        | LP Course 2 |
      | Course 3 | C3        | LP Course 3 |
      | Course 4 | C4        | LP Course 4 |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student  | C1     | student        |
      | teacher  | C1     | editingteacher |
    And the following config values are set as admin:
      | config            | value                                                      | plugin      |
      | restrictionfilter | timed,timed_duration,specific_course,parent_courses,manual | local_adele |
    And the following "local_adele > learningpaths" exist:
      | name           | description         | filepath                                                   | courses     | image                                                 |
      | StaekdNode LP1 | StaekdNode LP1 Desc | local/adele/tests/fixtures/learning_plan_stackednodes.json | C1,C2,C3,C4 | /local/adele/public/node_background_image/image_1.jpg |
    And I change viewport size to "1366x3000"

  @javascript
  Scenario: Adele usage: admin edit a learning path with stacked node created via DB
    Given I log in as "admin"
    And I click on "Learning Paths" "button" in the "#usernavigation" "css_element"
    And I should see "StackedNodeLP 2026" in the ".learningcardcont .learningcard" "css_element"
    And I should see "StackedNodeLP Descr 2026" in the ".learningcardcont .learningcard" "css_element"
    And I click on ".learningcardcont .learningcard" "css_element"
    And I should see "Collection" in the "[data-id='dndnode_1'] .card-header" "css_element"
    And I should see "Course 1" in the "[data-id='dndnode_1'] .card-body" "css_element"
    And I should see "Course 2" in the "[data-id='dndnode_1'] .card-body" "css_element"
    And I should see "Course 3" in the "[data-id='dndnode_1'] .card-body" "css_element"
    And I should see "Course 4" in the "[data-id='dndnode_2'] .card-body" "css_element"
    And "[data-id=\"dndnode_2dndnode_1\"]" "css_element" should exist
    ## Edit completion for course 1 - add customized "manual completion" checkbox.
    And I click on "[data-id='dndnode_1'] .icon-link .fa-tasks" "css_element"
    And I wait "1" seconds
    ## GitHub - ensure Catquiz installed
    And I should see "Catquiz Quiz" in the ".learning-path-nodes-container .nodes [data-draggable=\"Catquiz Quiz\"]" "css_element"
    And I should see "Node completion checkbox" in the ".learning-path-nodes-container .nodes [data-draggable=\"Node completion checkbox\"]" "css_element"
    ## Set requirement that 2 of 3 course have to be completed to complete the node.
    And I set the field "completion-condition_1-min" to "2"
    And I click on "Save" "button" in the ".vue-flow__panel.save-restore-controls" "css_element"
