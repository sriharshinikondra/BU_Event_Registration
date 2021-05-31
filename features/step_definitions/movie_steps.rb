
Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Instructions This is a Binghamton University Event Registration Web page. Inorder to use this service, you need to sign up or login ,then search for upcoming events and then register for the events.")
end

Given /the following profiles exist/ do |profiles_table|
  profiles_table.hashes.each do |profile|
    Profile.create! profile
  end 
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create! user
  end 
end

Given /the following authorizations exist/ do |authorizations_table|
  authorizations_table.hashes.each do |authorization|
    Authorization.create! authorization
  end 
end

 Then /^I will see "([^"]*)"$/ do |message|
   puts page.body
   expect(page.body).to have_content(message)
 end


# features/step_definitions/movie_steps.rb
Given /I am logged into BU Event Registration/ do
  steps %Q{
    Given I am on the BU Event Registration Landing Page   
    And I press "Register or Login with GitHub"
    And I am on the BU Event Registration Home Page
    }
end


# Then /^I will see "([^"]*)"$/ do |message|
#  puts page.body # <---
#  expect(page.body).to have_content(message)
# end