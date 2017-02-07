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

private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end
