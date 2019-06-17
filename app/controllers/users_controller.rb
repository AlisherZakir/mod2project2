class UsersController < ApplicationController
  skip_before_action :check_id, only: [:new, :create]
  def new
    @user = User.new
  end
  def create
    if params[:user][:password] != params[:user][:confirm_password]
      flash[:errors] = ["Your passwords should match"]
      return redirect_to new_user_path
    end
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
    @cont_room = @user.curr_room
    @wins = @user.wins.length
    @loses = @user.loses.length
    @draws = @user.draws.length
    @total = @wins + @loses + @draws
  end


end
