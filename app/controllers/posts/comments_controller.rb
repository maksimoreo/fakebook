class Posts::CommentsController < ApplicationController
  def create
    comment = Post.find(params[:post_id]).comments.create(**comment_params, user: current_user)
    flash[:notice] = 'Comment added!'
    redirect_to comment.post
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to @comment.post
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = 'Comment deleted'
    redirect_to comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
