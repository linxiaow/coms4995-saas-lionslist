users = [{:id => '997', :username => 'testauthor1', :email => 'testauthor1@columbia.edu', :password => 'MyDummyPassword1'},
		{:id => '998', :username => 'testauthor2', :email => 'testauthor2@columbia.edu', :password => 'MyDummyPassword2'},
		{:id => '999', :username => 'testauthor3', :email => 'testauthor3@columbia.edu', :password => 'MyDummyPassword3'}]

posts = [{:title => 'Test1', :content => 'AAA', :author => 'testauthor1', :author_id => '997', :category => 'furniture'},
    	  {:title => 'Test2', :content => 'BBB', :author => 'testauthor2', :author_id => '998', :category => 'sublease'},
    	  {:title => 'Test3', :content => 'CCC', :author => 'testauthor3', :author_id => '999', :category => 'furniture'},
  	 ]

posts.each do |post|
	Post.create!(post)
end

users.each do |user|
	User.create!(user)
end