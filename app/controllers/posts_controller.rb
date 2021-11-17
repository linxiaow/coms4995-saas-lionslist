class PostsController < ApplicationController
  skip_before_action :require_login, except: [:create, :new]
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @post = Post.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @current_user_id = session[:user_id]
  end

  def index
    puts "index!"
    @posts = Post.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @post = Post.create!(post_params)
    @post.author_id = session[:user_id]
    @post.save
    flash[:notice] = "#{@post.title} was successfully created."
    redirect_to posts_path
  end

  def edit
    @post = Post.find params[:id]
    puts "edit!"
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
    @post.destroy
    flash[:notice] = "Post '#{@post.title}' deleted."
    redirect_to posts_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def post_params
    params.require(:post).permit(:title, :content, :author, :category)
  end
end
