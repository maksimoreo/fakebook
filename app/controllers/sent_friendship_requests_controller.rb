class SentFriendshipRequestsController < ApplicationController
  def index
    @sent_friendship_requests = current_user.sent_friendship_requests
  end

  def create
    f = Friendship.new(to_user_id: params[:to_user_id], from_user_id: current_user.id)

    if f.save
      flash[:notice] = "You have sent friend request to #{f.to_user.username}. Wait for user response. ⏳"
    else
      flash[:alert] = "Could not send friend request to #{f.to_user.username}"
    end

    redirect_to user_path(f.to_user)
  end

  def destroy
    friendship = Friendship.find_by_id(params[:id])

    if friendship.nil?
      head 404
    elsif !friendship.of_user? current_user
      head 403
    else
      friendship.destroy
      redirect_to sent_friendship_requests_path
    end
  end
end
