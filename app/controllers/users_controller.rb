class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      render json: {'error': @user.errors.full_messages}
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user && current_user == @user
      render json: {'error': 'You cannot see this user'}, status: 403
    end
  end

  def bad_worker
    user_id = params[:user_id].to_i
    if current_user && current_user.id == user_id
      BadWorker.perform_async(user_id)
      render json: {'message': 'Performing job'}
    else
      render json: {'error': 'You cannot do this'}, status: 403
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
