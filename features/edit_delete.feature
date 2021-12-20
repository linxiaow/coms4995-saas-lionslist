Feature: edit and delete existing posts

  As a Lionlist user
  So that I update details of posts I've made and take down ones that are no longer available
  I want to edit and remove posts I've made

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

Scenario: edit a post on Lionlist
  Given I am logged in with provider "google_oauth2"
  And I am on the details page for "post1"
  And   I follow "Edit"
  Then  I should be on the edit page for "post1"
  When  I fill in "Title" with "edited_post"
  And   I press "Update post info"
  Then  I should be on the details page for "edited_post"
  And   I should see "edited_post was successfully updated."
  And   I should see "edited_post"
  And   I should not see "post1"

Scenario: delete a post on Lionlist
  Given I am logged in with provider "google_oauth2"
  And I am on the details page for "post2"
  And   I press "Offshelf"
  Then  I should be on the Lionlist home page
  And   I should see "Post 'post2' deleted."
  And   I should not see "More about post2"

Scenario: forcefully enter edit page without login
  Given I am on the edit page for "post1"
  Then I should be on the error page