Feature: display list of posts filtered by category, author, and title
 
  As a Lionlist user
  So that I can quickly browse posts appropriate for my choice
  I want to see posts matching only certain category, author, and title

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

  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page

Scenario: restrict to posts with 'furniture' category
  When  I select "furniture" from "category"
  And I press "Search"
  Then I should see "post1"
  Then I should see "post2"
  Then I should not see "post3"
  Then I should not see "post4"

Scenario: restrict to posts with 'Example User' author
  When  I fill in "author" with "Example User"
  And I press "Search"
  Then I should see "post1"
  Then I should see "post2"
  Then I should not see "post3"
  Then I should not see "post4"

Scenario: restrict to posts with 'post1' titile
  When  I fill in "title" with "post1"
  And I press "Search"
  Then I should see "post1"
  Then I should not see "post2"
  Then I should not see "post3"
  Then I should not see "post4"

Scenario: no filter applied
  And I press "Search"
  Then I should see "post1"
  Then I should see "post2"
  Then I should see "post3"
  Then I should see "post4"