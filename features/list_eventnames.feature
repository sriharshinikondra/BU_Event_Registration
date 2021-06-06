# feature/list_eventnames.feature
Feature:
As a student
I want to search and lookup events
So that I can find a event 

Background: authorization and user in database

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester SUNY| stester@binghamton.edu |
  
  Given I am logged into BU Event Registration
  
@omniauth_test5  
Scenario: list eventnames
Then I will see "BU Event Registration"



@omniauth_test6
Scenario: list of events
  Given I am on the BU Event Registration Home Page
  Then I will see "List of Eventnames"
  
  