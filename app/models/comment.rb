class Comment < ActiveRecord::Base
    belongs_to(
        :post, # Comment attribute of with datatype Post
        class_name: 'Post', # datatype of attribute
        foreign_key: 'post_id', # name of column containing FK
        inverse_of: :comments # attribute on other side of association (array containing all McQuestion objects belonging to a quiz)
    )
end
