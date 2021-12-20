Feature: display user information and all posts of this user on profile page

  As a Lionlist user
  So that I can see all my posts and my information on my profile page
  I want to view all my posts and my information details

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | author_id | content       |
  | post1 | furniture | Example User | 4       | test content1 |
  | post2 | furniture | Example User | 4         | test content2 |
  | post3 | sublease  | author2 | 2         | test content3 |
  | post4 | sublease  | author3 | 3         | test content4 |

  Given the following users exist:
  | username | email             | password        | id |
  | author1  | author1@gmail.com | MyDummyPassword | 1  |
  | author2  | author2@gmail.com | MyDummyPassword | 2  |
  | author3  | author3@gmail.com | MyDummyPassword | 3  |
  | Example User | hz2712@columbia.edu | MyDummyPassword | 4|

Scenario: navigate to my profile page from Lionlist home page
  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page
  When  I follow "Profile"
  Then  I should be on the profile page
  And   I should see "Example User's Profile"
  And   I should see "Email: hz2712@columbia.edu"
  And   I should see "post1"
  And   I should see "post2"
  And   I should see "Back to homepage"
  And   I should see "Log out"
  And   I should see "Update your profile"

Scenario: navigate to profile page from details page
  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page
  When  I follow "More about post3"
  Then  I should be on the details page for "post3"
  And   I should see "author2"
  When  I follow "author2"
  Then  I should be on the profile page for "2"
  And   I should see "author2's Profile"
  And   I should see "post3"
  And   I should see "Back to homepage"
  And   I should see "Log out"
  And   I should not see "Update your profile"

Scenario: update user profile on profile page
  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page
  When  I follow "Profile"
  Then  I should be on the profile page
  When  I follow "Update your profile"
  Then  I should be on the edit profile page
  When  I fill in "Phone Number" with "313123"
  And   I fill in "Address" with "3000 Broadway"
  And   I fill in "Bio" with "Hi nice to meet you"
  And   I press "Update Personal Profile"
  Then  I should be on the profile page
  And   I should see "Example User's personal profile was successfully updated."
  And   I should see "Phone Number: 313123"
  And   I should see "Address: 3000 Broadway"
  And   I should see "Self Introduction: Hi nice to meet you"

Scenario: forcefully enter profile page without login
  Given I am on the profile page
  Then I should be on the error page