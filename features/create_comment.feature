Feature: add new comments

  As a Lionlist user
  So that I can leave my comments for a post
  I want to add new comments for a post on Lionlist

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

Scenario: create a comment on Lionlist
  Given I am logged in with provider "google_oauth2"
  And I am on the details page for "post1"
  When  I fill in "comment-content-box" with "test comment"
  And   I press "Save"
  Then  I should be on the details page for "post1"
  And   I should see "Your comment was successfully created."
  And   I should see "test comment"