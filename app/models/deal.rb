class Deal < ActiveRecord::Base
    belongs_to(
        :post, # Comment attribute of with datatype Post
        class_name: 'Post', # datatype of attribute
        foreign_key: 'post_id', # name of column containing FK
        inverse_of: :deals # attribute on other side of association
    )
    def self.search_purchase_requests buyer_id
        where(
            [
                "buyer_id = :buyer_id and status = :status",
                {
                    buyer_id: buyer_id,
                    status: "unsettled"
                }
            ]
        )
    end

    def self.search_selling_requests seller_id
        where(
            [
                "seller_id = :seller_id and status = :status",
                {
                    seller_id: seller_id,
                    status: "unsettled"
                }
            ]
        )
    end

    def self.search_unrated_deal buyer_id
        where(
            [
                "buyer_id = :buyer_id and status = :status and rating = :rating",
                {
                    buyer_id: buyer_id,
                    status: "accepted",
                    rating: -1
                }
            ]
        )
    end

    def self.search_involved_deal user_id
        where(
            [
                "(buyer_id = :user_id or seller_id = :user_id) and status != :status",
                {
                    user_id: user_id,
                    status: "unsettled"
                }
            ]
        )
    end

    def self.calcualte_rating user_id
        involved_deals = where(
            [
                "seller_id = :user_id and status != :status and rating != :rating",
                {
                    user_id: user_id,
                    status: "unsettled",
                    rating: -1
                }
            ]
        )
        rating = involved_deals.average(:rating)
        if rating.nil?
            return 0
        else
            return rating
        end
    end

    def self.get_all_unsettled_requests_from_post_id post_id
        where(
            [
                "post_id = :post_id and status = :status",
                {
                    post_id: post_id,
                    status: "unsettled",
                }
            ]
        )
    end
end
