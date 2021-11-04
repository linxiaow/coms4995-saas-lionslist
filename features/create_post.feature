Feature: add new posts

  As a Lionlist user
  So that I can look for buyers/tenents for my furniture/sublease
  I want to post listings about furniture or sublease on Lionlist

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | content       |
  | post1 | furniture | author1 | test content1 |
  | post2 | furniture | author1 | test content2 |
  | post3 | sublease  | author2 | test content3 |
  | post4 | sublease  | author3 | test content4 |

Scenario: create a post on Lionlist
  Given I am on the Lionlist home page
  And  I follow "Add new post"
  Then I should be on the new post page
  When I fill in "Title" with "test_post"
  And I select "sublease" from "Category"
  And I fill in "Author" with "test_author"
  And I fill in "Content" with "test_content"
  And I press "Save Changes"
  Then I should be on the Lionlist home page
  And I should see "test_post was successfully created."
  And I should see "test_author"