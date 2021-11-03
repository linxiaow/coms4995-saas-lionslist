require 'rails_helper'

RSpec.describe PostsController, type: :controller do  
  describe "creates" do
    it "post with valid parameters" do
      get :create, {:post => {:title => "Post Title #1", :author => "Author #1",
                    :category => "furniture", :content => "I posted something."}}
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to match(/Post Title #1 was successfully created./)
      Post.find_by(:title => "Post Title #1").destroy
    end
  end
  
  describe "updates" do
    it "post's valid attributes" do
      post = Post.create(:title => "Post Title #2", :author => "Author #2",
                    :category => "furniture", :content => "I posted some other things.")
      get :update, {:id => post.id, :post =>
        {:content => "content changed to some other things."}
      }
      expect(response).to redirect_to post_path(post)
      expect(flash[:notice]).to match(/Post Title #2 was successfully updated./)
      post.destroy
    end
  end

  describe "destroys" do
    it "movies with valid parameters" do
      post = Post.create(:title => "Post Title #3", :author => "Author #3",
                    :category => "furniture", :content => "I posted some other things.")
      get :destroy, {:id => post.id}
#       expect(response).to redirect_to posts_path
#       expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      # Post.find_by(:title => "Post Title #3").destroy
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to match(/Post 'Post Title #3' deleted./)
    end
  end

end