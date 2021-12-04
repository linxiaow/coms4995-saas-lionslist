class CommentsController < ApplicationController
    skip_before_action :require_login, except: [:create]

    def create
        user = User.find(session[:user_id])
        post = Post.find(params[:id])
        comment = post.comments.build(comment_params)
        comment.author_id = session[:user_id]
        comment.author = user.username
        comment.save
        flash[:notice] = "Your comment was successfully created."
        redirect_to show_post_path
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def comment_params
        params.require(:comment).permit(:content, :author)
    end
end