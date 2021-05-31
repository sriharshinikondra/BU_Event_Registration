Feature:
As a student
I want to schedule an appointment
So that I can get a eventorganiser session

Background: authorization and user in database  # <---- Add this block

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester Suny| stester@binghamton.edu |
  
  Given the following eventnames exist:
  |eventnamecode | title | description | create_date |
  |1453 | Economics | Economics in detail by James | 05-12-2021 |
  
  Given the following schedules exist:
  |eventorganiser | eventname | timeslot |
  |jane doe | Economics | 05-12-2021|
  
  Given I am logged into BU Event Registration

@omniauth_test7  
Scenario: schedule a session
Then I will see "Schedule a Session"

@omniauth_test8
Scenario: adding a session
Given I am on Schedule a Session Page
Then I will see "Available Events "

