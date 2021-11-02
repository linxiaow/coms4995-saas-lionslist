Feature: display all posts on homepage and post details on details page

  As a Lionlist user
  So that I can quickly browse all posts to find ones I might be interested in
  I want to view all available posts and go to details page to a specific post

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | content       |
  | post1 | furniture | author1 | test content1 |
  | post2 | furniture | author1 | test content2 |
  | post3 | sublease  | author2 | test content3 |
  | post4 | sublease  | author3 | test content4 |

Scenario: see all posts on Lionlist Homepage
  Given I am on the Lionlist home page
  Then  I should see "post1"
  Then  I should see "post2"
  Then  I should see "post3"
  Then  I should see "post4"

Scenario: navigate to details page and view details of a post
  Given I am on the Lionlist home page
  When  I follow "More about post1"
  Then  I should be on the details page for "post1"
  And   I should see "test content1"
  And   I should see "author1"
  And   I should not see "post2"

Scenario: navigate back to Lionlist home page from details page
  Given I am on the details page for "post1"
  When  I follow "Back to post list"
  Then  I should be on the Lionlist home page
  And   I should see "post1"