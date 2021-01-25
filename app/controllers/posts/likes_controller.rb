class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = Post.find(params[:post_id]).likes.new(user: current_user)
    like.save
    flash[:success] = 'Added like to this post! 👍'
    redirect_to like.post
  end

  def destroy
    like = Post.find(params[:post_id]).likes.find(params[:id])
    like.destroy
    flash[:notice] = 'Removed like from this post. 👎'
    redirect_to like.post
  end
end
