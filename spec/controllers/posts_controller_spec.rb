require 'rails_helper'

RSpec.describe PostsController, type: :controller do  
  describe "creates" do
    it "post with valid parameters" do
      login_with_oauth
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

  describe 'edit' do
    post = FactoryGirl.create(:post)
    before do
      get :edit, id: post.id
    end

    it 'finds the post' do
      expect(assigns(:post)).to eql(post)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'index' do
    movie = FactoryGirl.create(:post)

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
  
  describe 'show' do
    post = FactoryGirl.create(:post)
    before(:each) do
      get :show, id: post.id
    end

    it 'finds the post' do
      expect(assigns(:post)).to eql(post)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

end