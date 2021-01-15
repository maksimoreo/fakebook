class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    friendship = Friendship.find_by_user_ids(current_user.id, params[:id])

    if friendship.nil?
      head 404
    elsif !friendship.of_user?(current_user)
      head 403
    else
      redirect_to user_path(friendship.friend_of_user(current_user))
      friendship.destroy
    end
  end
end
