class UsersController < ApplicationController
  skip_before_action :check_id, only: [:new, :create]
  def new
    return redirect_to home_path if curr_user
    @user = User.new
    render layout: "sign_up"
  end
  def create
    if params[:user][:password] != params[:user][:confirm_password]
      flash[:errors] = ["Your passwords should match"]
      return redirect_to new_user_path
    end
    @user = User.create(params.require(:user).permit(:username, :password))
    if @user.valid?
      session[:username] = params[:user][:username]
      # @user.update(avatar: image_url("images/default_image.png"))
      redirect_to home_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end
  def show
    @user = User.find(params[:id])
    @wins = @user.wins.length
    @loses = @user.loses.length
    @draws = @user.draws.length
    @total = @wins + @loses + @draws
    @ratio = @user.ratio ? "#{(@user.ratio * 100).round}%" : "N/A"
  end
  def home
    @user = User.find_by(username: curr_user)
    @name = @user.alias || @user.first_name || @user.username
    @cont_room = @user.curr_room
    @wins = @user.wins.length
    @loses = @user.loses.length
    @draws = @user.draws.length
    @total = @wins + @loses + @draws
    @ratio = @user.ratio ? "#{(@user.ratio * 100).round}%" : "N/A"
  end

  def edit
    @user = User.find_by(username: curr_user)
  end

  def update
      @user = User.find_by(username: curr_user)
  
      @user.update(params.require(:user).permit(:avatar, :password, :first_name, :last_name, :alias))
      redirect_to home_path
  end

  def destroy
    @user = User.find_by(username: curr_user)
    session.delete(:username)
    @user.destroy
    redirect_to root_path
  end

end
