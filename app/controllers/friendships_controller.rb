class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end

  def create
    # Unpack params
    f = Friendship.create(**friendship_params, from_user_id: current_user.id)
    flash[:notice] = "You sended friend request to #{User.find(f.to_user_id).username}"
    redirect_to user_path(f.to_user)
  end

  # http verb: PATCH
  def accept
    friendship = Friendship.find(params[:id])

    if friendship.of_user?(current_user)
      friend = friendship.friend_of_user(current_user)
      friendship.update_attribute(:accepted, true)
      redirect_to user_path(friend)
      flash[:notice] = "#{friend.username} is now ur friend! 🎉🥳🤝"
    else
      head 403
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])

    if friendship.of_user?(current_user)
      redirect_to user_path(friendship.friend_of_user(current_user))
      friendship.destroy
    else
      head 403
    end
  end

  # http verb: GET
  def incoming_requests
    @incoming_requests = current_user.incoming_friendship_requests
  end

  private

  def friendship_params
    params.require(:friendship).permit(:to_user_id)
  end
end
