class TimelineController < ApplicationController
  def show
    user_ids = current_user.friends.ids.append(current_user.id)
    @posts = Post.where(author_id: user_ids).order(created_at: :desc)
  end
end
