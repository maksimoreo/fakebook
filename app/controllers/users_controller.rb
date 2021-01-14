class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friendship = @user.friendship(current_user)
  end
end
