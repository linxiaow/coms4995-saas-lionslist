class Post < ActiveRecord::Base
	has_many(
		:deals, # Post attribute containing an array of Comment objects
		class_name: 'Deal', # datatype of attribute
		foreign_key: 'post_id', # name of column containing FK in other table
		inverse_of: :post, # attribute on other side of association (parent Post object)
		dependent: :destroy # if a post is destroyed, also destroy all of its comments
	)
	def self.search_author author_id
		where(author_id: author_id)
	end

	def self.all_onshelf_posts
		where([
			"onshelf = :onshelf",
			{onshelf: 1}
		])
	end
end
