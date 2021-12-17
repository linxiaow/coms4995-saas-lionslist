Feature: add new posts

  As a Lionlist user
  So that I can look for buyers/tenents for my furniture/sublease
  I want to post listings about furniture or sublease on Lionlist

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

Scenario: create a post on Lionlist
  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page
  And  I follow "Add new post"
  Then I should be on the new post page
  When I fill in "Title" with "test_post"
  And I select "sublease" from "Category"
  And I fill in "Content" with "test_content"
  And I press "Create your post"
  Then I should be on the Lionlist home page
  And I should see "test_post was successfully created."
  And I should see "Example User"

Scenario: create a post without login
  Given I am on the new post page
  Then I should be on the error page
  And I should see "You must be logged in to access this section"