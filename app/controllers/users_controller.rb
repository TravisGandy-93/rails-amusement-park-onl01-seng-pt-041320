class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id

    redirect_to @user
  end

  def new
    @user = User.new
  end

  def show

    @user = User.find(params[:id])

    if session[:user_id] != @user.id

      redirect_to root_path
    end
  end

  def index
    @users = User.all
  end

  def add_ride

    attraction = Attraction.find_by(id: params[:attraction][:id])
    current_user
    ride = Ride.create(attraction_id: attraction.id, user_id: current_user.id )
    flash[:message] = ride.take_ride

    redirect_to current_user
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
  end
end
