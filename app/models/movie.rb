class Movie < ActiveRecord::Base
  def self.with_director(director)
    similar_movies = Movie.where(director: director)
    return similar_movies
  end
end
