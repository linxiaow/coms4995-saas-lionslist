class Post < ActiveRecord::Base
	has_many(
		:comments, # Post attribute containing an array of Comment objects
		class_name: 'Comment', # datatype of attribute
		foreign_key: 'post_id', # name of column containing FK in other table
		inverse_of: :post, # attribute on other side of association (parent Post object)
		dependent: :destroy # if a post is destroyed, also destroy all of its comments
	)

	def self.search_author author_id
		where(author_id: author_id)
	end
end
