class UsersController < ApplicationController
  skip_before_action :check_id, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    @user = User.create(params.require(:user).permit(:username, :password))
    if @user.valid?
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def home
    @user = User.find_by(username: curr_user)
  end


end
