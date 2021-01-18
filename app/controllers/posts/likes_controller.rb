class Posts::LikesController < ApplicationController
  def create
    like = Post.find(params[:post_id]).likes.new(user: current_user)
    like.save
    redirect_to like.post
  end

  def destroy
    like = Post.find(params[:post_id]).likes.find(params[:id])
    like.destroy
    redirect_to like.post
  end
end
