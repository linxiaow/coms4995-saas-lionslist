# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

posts = [{:title => 'Test1', :content => 'AAA', :author => 'testauthor1', :author_id => '-1', :category => 'furniture'},
    	  {:title => 'Test2', :content => 'BBB', :author => 'testauthor2', :author_id => '-1', :category => 'sublease'},
    	  {:title => 'Test3', :content => 'CCC', :author => 'testauthor3', :author_id => '-2', :category => 'furniture'},
  	 ]

posts.each do |post|
	Post.create!(post)
end