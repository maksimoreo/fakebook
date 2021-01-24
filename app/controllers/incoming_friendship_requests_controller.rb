class IncomingFriendshipRequestsController < ApplicationController
  before_action :find_friendship, only: [:update, :destroy]

  def index
    @incoming_friendship_requests = current_user.incoming_friendship_requests
  end

  def update
    friend = @friendship.friend_of_user(current_user)
    @friendship.update_attribute(:accepted, true)
    redirect_to user_path(friend)
    flash[:notice] = "#{friend.username} is now ur friend! 🎉🥳🤝"
  end

  def destroy
    friend = @friendship.friend_of_user(current_user)
    redirect_to user_path(friend)
    @friendship.destroy
    flash[:notice] = "#{friend.username} is not your friend anymore... 🙁"
  end

  private

  def find_friendship
    @friendship = Friendship.find(params[:id])

    if @friendship.nil?
      head 404
    elsif !@friendship.of_user?(current_user)
      head 403
    end
  end
end
