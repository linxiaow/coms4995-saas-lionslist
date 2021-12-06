class Post < ActiveRecord::Base
	has_many(
		:comments, # Post attribute containing an array of Comment objects
		class_name: 'Comment', # datatype of attribute
		foreign_key: 'post_id', # name of column containing FK in other table
		inverse_of: :post, # attribute on other side of association (parent Post object)
		dependent: :destroy # if a post is destroyed, also destroy all of its comments
	)
	has_many(
		:deals, # Post attribute containing an array of Comment objects
		class_name: 'Deal', # datatype of attribute
		foreign_key: 'post_id', # name of column containing FK in other table
		inverse_of: :post, # attribute on other side of association (parent Post object)
		dependent: :destroy # if a post is destroyed, also destroy all of its comments
	)

	def self.search_filter(posts, category, author, title)
		filter_hash = {:category => category, :author => author, :title => title}
		if category.nil? || category.empty?
			filter_hash.delete(:category)
		end
		if author.nil? || author.empty?
			filter_hash.delete(:author)
		end
		if title.nil? || title.empty?
			filter_hash.delete(:title)
		end
		return posts.where(filter_hash)
		# return Post.where(filter_hash)
	end

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
