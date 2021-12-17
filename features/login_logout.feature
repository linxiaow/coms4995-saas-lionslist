Feature: add new posts

  As a Lionlist user
  So that I can access components that require login
  I want to log in and log out with my Columbia email

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | author_id | content       |
  | post1 | furniture | author1 | 1         | test content1 |
  | post2 | furniture | author1 | 1         | test content2 |
  | post3 | sublease  | author2 | 2         | test content3 |
  | post4 | sublease  | author3 | 3         | test content4 |

  Given the following users exist:
  | username | email             | password        | id |
  | author1  | author1@gmail.com | MyDummyPassword | 1  |
  | author2  | author2@gmail.com | MyDummyPassword | 2  |
  | author3  | author3@gmail.com | MyDummyPassword | 3  |

Scenario: homepage when user not logged in
  Given I am on the Lionlist home page
  Then I should see "Log In or Sign Up"
  And I should not see "Profile"
  And I should not see "Log out"

Scenario: homepage when user logged in
  Given I am logged in with provider "google_oauth2"
  Then I should be on the Lionlist home page
  And I should see "Profile"
  And I should see "Log out"
  And I should not see "Log In or Sign Up"

Scenario: homepage after logout
  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page
  And I follow "Log out"
  Then I should be on the Lionlist home page
  And I should see "You have logged out!"
  Then I should see "Log In or Sign Up"
  And I should not see "Profile"
  And I should not see "Log out"