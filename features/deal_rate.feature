Feature: add new comments

  As a Lionlist seller
  So that I can post information for furniture and leasing information
  I want to confirm, decline deals on Lionlist

  As a Lionlist buyer
  So that I can buy furniture and get leasing information
  I want to request deals on Lionlist

Background: posts in database

  Given the following posts exist:
  | title    | category  | author  | author_id | content       |
  | laptop   | furniture | Example User | 4    | sell laptop |
  | sofa     | furniture | seller1 | 1         | sell sofa |
  | desk     | furniture | seller2 | 2         | sell desk |
  | chair    | furniture | seller2 | 2         | sell chair |
  | condo    | sublease  | seller1 | 1         | sublease condo |
  | apartment| sublease  | seller2 | 2         | sublease apartment |
  

  Given the following users exist:
  | username | email               | password        | id |
  | seller1  | seller1@gmail.com   | MyDummyPassword | 1  |
  | seller2  | seller2@gmail.com   | MyDummyPassword | 2  |
  | buyer1   | buyer1@gmail.com    | MyDummyPassword | 3  |
  | Example User | hz2712@columbia.edu | MyDummyPassword | 4|

Scenario: see request deal button
  Given I am logged in with provider "google_oauth2"
  When I am on the home page
  Then I should see "Request Deal" button

Scenario: buyer request a deal
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  Then I go to the profile page
  Then I should see "laptop" inside "purchase request from himself"

Scenario: seller sees a deal
  Given I am logged in with provider "google_oauth2"
  When a buyer requests the deal
  And I go to the profile page
  Then I should see "laptop" inside "purchase made to him"

Scenario: Several buying requests
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  And I go to the home page
  And I press the first "Request Deal"
  And I press the first "☑️"
  Then I should see "declined" inside "past involved deals"
  And I should see "accepted" inside "past involved deals"
  And I should see "Unrated" inside "past involved deals"

Scenario: Seller offshelfs the goods
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  And I go to the home page
  And I press the first "Request Deal"
  And I press the first "Offshelf"
  Then I go to the profile page
  Then I should see "declined" inside "past involved deals"
  And I should not see "accepted" inside "past involved deals"

Scenario: Purchase awaits rating
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  And I press the first "☑️"
  Then I should see "laptop" inside "unrated purchase"

Scenario: Purchase is canceled
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  And I press the first "X"
  And I should not see "unsettled"

Scenario: Rate a deal
  Given I am logged in with provider "google_oauth2"
  When I press the first "Request Deal"
  Then I should see "0" inside "rating score"
  And I press the first "☑️"
  And I select "4" from the first "unrated purchase"
  And I press the first "Save"
  Then I should see "4" inside "past involved deals"
  And I should see "4" inside "rating score"
  And I should not see "Unrated" inside "past involved deals"
  