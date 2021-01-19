class PostsController < ApplicationController
  def index
    user_ids = current_user.friends.ids.append(current_user.id)
    @posts = Post.where(author_id: user_ids)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post created! 🌞'
      redirect_to @post
    else
      flash.now[:alert] = 'Cannot create post, see errors 🤔'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @like = @post.likes.find_or_initialize_by(user: current_user)
    @comment = @post.comments.new(user: current_user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Post updated! 🌞'
      redirect_to @post
    else
      flash.now[:alert] = 'Cannot update post, see errors 🤔'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = 'Post deleted'
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
