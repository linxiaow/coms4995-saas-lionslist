require 'rails_helper'

RSpec.describe PostsController, type: :controller do
#   before(:all) do
#     if Post.where(:director => "Jon Favreau").empty?
#       Post.create(:title => "Iron Man", :director => "Jon Favreau",
#                    :rating => "PG-13", :release_date => "2008-05-02")
#       Post.create(:title => "Spider-Man: Homecoming", :director => "Jon Favreau",
#                    :rating => "PG-13", :release_date => "2017-07-07")
#     end
#
#     if Post.where(:title => "Big Hero 6").empty?
#       Post.create(:title => "Big Hero 6",
#                    :rating => "PG", :release_date => "2014-11-07")
#     end
#   end
#
#   describe "when trying to find movies by the same director" do
#     it "returns a valid collection when a valid director is present" do
#       get :show_same_director, {:id => Post.find_by_title("Iron Man")}
#       expect(assigns(:movies)).to eq(
#         [
#           Post.find_by_title("Iron Man"),
#           Post.find_by_title("Spider-Man: Homecoming")
#         ]
#       )
#       expect(response).to render_template "show_same_director"
#     end
#
#     it "redirects to index with a warning when no director is present" do
#       get :show_same_director, {:id => Post.find_by_title("Big Hero 6")}
#       expect(response).to redirect_to movies_path
#       expect(flash[:warning]).to match(/'Big Hero 6' has no director info/)
#     end
#   end
  
  describe "creates" do
    it "post with valid parameters" do
      get :create, {:Post => {:title => "Post Title #1", :author => "Author #1",
                    :category => "furniture", :date => "2021-11-03", :content => "I posted something."}}
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to match(/Post Title #1 was successfully created./)
      Post.find_by(:title => "Post Title #1").destroy
    end
  end
  
  describe "updates" do
    it "movie's valid attributes" do
      post = Post.create(:title => "Post Title #2", :author => "Author #2",
                    :category => "furniture", :date => "2021-11-03", :content => "I posted some other things.")
      get :update, {:id => post.id, :post =>
        {:content => "content changed to some other things."}
      }
      expect(response).to redirect_to posts_path(post)
      expect(flash[:notice]).to match(/Post Title #2 was successfully updated./)
      post.destroy
    end
  end

  describe "destroys" do
    it "movies with valid parameters" do
      get :create, {:Post => {:title => "Post Title #3", :author => "Author #3",
                    :category => "furniture", :date => "2021-11-03", :content => "I posted some other other things."}}
#       expect(response).to redirect_to posts_path
#       expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      Post.find_by(:title => "Post Title #3").destroy
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to match(/Post Post Title #3 deleted./)
    end
  end

end