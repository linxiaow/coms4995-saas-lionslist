users = [{:id => '-1', :username => 'John Smith', :email => 'testauthor1@columbia.edu', :password => 'MyDummyPassword1'},
	{:id => '-2', :username => 'Teddy Bear', :email => 'testauthor2@columbia.edu', :password => 'MyDummyPassword2'},
	{:id => '-3', :username => 'Foo Bar', :email => 'testauthor3@columbia.edu', :password => 'MyDummyPassword3'}]

posts = [{:title => 'Second Hand Sofa', :content => '1 year usage, good condition', :author => 'John Smith', :author_id => '-1', :category => 'furniture'},
	  {:title => 'Apartment @ Enclave', :content => 'Master bedroom, only 2000 a month!', :author => 'Teddy Bear', :author_id => '-2', :category => 'sublease'},
	  {:title => 'TV', :content => "I don't want it because it is too large. Contact me if you want it", :author => 'Foo Bar', :author_id => '-3', :category => 'furniture'},
   ]

posts.each do |post|
Post.create!(post)
end

users.each do |user|
User.create!(user)
end