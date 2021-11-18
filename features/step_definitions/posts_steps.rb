Given /the following posts exist/ do |posts_table|
  posts_table.hashes.each do |post|
    Post.create post
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    curr_user = User.find_or_create_by(id: user['id']) do |u|
      u.username = user['username']
      u.email = user['email']
      u.password = user['password']
    end
    curr_user.username = user['username']
    curr_user.email = user['email']
    curr_user.password = user['password']
    curr_user.save
  end
end

Given /^I am logged in with provider "([^"]*)"$/ do |provider|
  visit "/auth/#{provider.downcase}/callback"
end