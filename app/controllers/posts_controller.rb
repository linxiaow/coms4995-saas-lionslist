class PostsController < ApplicationController
  skip_before_action :require_login, except: [:create, :new, :edit, :update, :destroy]
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @post = Post.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @current_user_id = session[:user_id]
    @userid = @post.author_id
  end

  def index
    @posts = Post.all_onshelf_posts

    if session[:sort_by] != nil
      @sort_by = session[:sort_by]
    else
      @sort_by = ""
    end
    if params[:category] != nil
      session[:category] = params[:category]
    end
    if params[:author] != nil
      session[:author] = params[:author]
    end
    if params[:title] != nil
      session[:title] = params[:title]
    end
    if session[:category] != nil
      @category = session[:category]
    else
      @category = ""
    end
    if session[:author] != nil
      @author = session[:author]
    else
      @author = ""
    end
    if session[:title] != nil
      @title = session[:title]
    else
      @title = ""
    end
    @posts = Post.search_filter(@posts, @category, @author, @title)

    session[:sort_by] = params[:sort_by]
    if params[:sort_by] == 'title'
      @posts.order!('title')
      @sort_by = 'title'
    elsif params[:sort_by] == 'category'
      @posts.order!('category')
      @sort_by = 'category'
    elsif params[:sort_by] == 'author'
      @posts.order!('author')
      @sort_by = 'author'
    elsif params[:sort_by] == 'created date'
      @posts.order!('created_at DESC')
      @sort_by = 'created date'
    else
      @sort_by = ''
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.find(session[:user_id])
    @post = Post.create!(post_params)
    @post.author_id = session[:user_id]
    @post.author = @user.username
    @post.save
    flash[:notice] = "#{@post.title} was successfully created."
    redirect_to posts_path
  end

  def edit
    @post = Post.find params[:id]
  end
  
  # def show_same_director
  #   puts "same director routes!"
  #   movie = Movie.find params[:id]
  #   director = Movie.find(movie.id).director
  #   if director.nil? or director.empty?
  #     flash[:warning] = "'#{movie.title}' has no director info"
  #     redirect_to movies_path
  #   end
  #   @movies = Movie.with_director(director)
  # end
  
  def update
    @post = Post.find params[:id]
    @post.update_attributes!(post_params)
    flash[:notice] = "#{@post.title} was successfully updated."
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    # @post.destroy
    @post.onshelf = 0
    @post.save
    all_requests = Deal.get_all_unsettled_requests_from_post_id(@post.id)
    all_requests.each do |request|
        request.status = 'declined'
        request.save
    end

    flash[:notice] = "Post '#{@post.title}' deleted."
    redirect_to posts_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def post_params
    params.require(:post).permit(:title, :author, :content, :category)
  end
end
