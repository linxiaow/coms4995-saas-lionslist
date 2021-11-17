class Post < ActiveRecord::Base
	def self.search_author author_id
		where(author_id: author_id)
	end
end
