Feature: edit and delete existing posts

  As a Lionlist user
  So that I update details of posts I've made and take down ones that are no longer available
  I want to edit and remove posts I've made

Background: posts in database

  Given the following posts exist:
  | title | category  | author  | content       |
  | post1 | furniture | author1 | test content1 |
  | post2 | furniture | author1 | test content2 |
  | post3 | sublease  | author2 | test content3 |
  | post4 | sublease  | author3 | test content4 |

Scenario: edit a post on Lionlist
  Given I am on the details page for "post1"
  And   I follow "Edit"
  Then  I should be on the edit page for "post1"
  When  I fill in "Title" with "edited_post"
  And   I press "Update Post Info"
  Then  I should be on the details page for "edited_post"
  And   I should see "edited_post was successfully updated."
  And   I should see "edited_post"
  And   I should not see "post1"

Scenario: delete a post on Lionlist
  Given I am on the details page for "post2"
  And   I follow "Delete"
  Then  I should be on the Lionlist home page
  And   I should see "Post 'post2' deleted."
  And   I should not see "More about post2"