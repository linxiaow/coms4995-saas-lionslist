Given /the following posts exist/ do |posts_table|
  posts_table.hashes.each do |post|
    Post.create post
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Given /^I am logged in with provider "([^"]*)"$/ do |provider|
  visit "/auth/#{provider.downcase}/callback"
end