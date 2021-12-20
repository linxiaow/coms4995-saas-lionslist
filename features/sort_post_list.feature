Feature: display list of posts sorted by different criteria

  As a Lionlist user
  So that I can quickly browse posts based on my preferences
  I want to see posts sorted by category, author, title, and create date

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | author_id | content       | created_at    |
  | post1 | furniture | Example User | 4       | test content1 | 21-Jun-2018    |
  | post2 | furniture | Example User | 4         | test content2 | 21-Jun-2019  |
  | post3 | sublease  | author2 | 2         | test content3 | 21-Jun-2020   |
  | post4 | sublease  | author3 | 3         | test content4 | 21-Jun-2021   |

  Given the following users exist:
  | username | email             | password        | id |
  | author1  | author1@gmail.com | MyDummyPassword | 1  |
  | author2  | author2@gmail.com | MyDummyPassword | 2  |
  | author3  | author3@gmail.com | MyDummyPassword | 3  |
  | Example User | hz2712@columbia.edu | MyDummyPassword | 4|

  Given I am logged in with provider "google_oauth2"
  And I am on the Lionlist home page

Scenario: sort posts by title
  When I select "title" from "sort_by"
  And I press "Search"
  Then I should see "post1" before "post2"
  Then I should see "post2" before "post3"
  Then I should see "post3" before "post4"

Scenario: sort posts by category
  When I select "category" from "sort_by"
  And I press "Search"
  Then I should see "post1" before "post2"
  Then I should see "post2" before "post3"
  Then I should see "post3" before "post4"

Scenario: sort posts by author
  When I select "author" from "sort_by"
  And I press "Search"
  Then I should see "post1" before "post2"
  Then I should see "post2" before "post3"
  Then I should see "post3" before "post4"

Scenario: sort posts by author
  When I select "most recent" from "sort_by"
  And I press "Search"
  Then I should see "post4" before "post3"
  Then I should see "post3" before "post2"
  Then I should see "post2" before "post1"