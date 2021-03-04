class UsersController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notices] = "User #{@user.username} saved successfully!"
			login_user!(@user)
			# redirect_to root_path
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password)
	end
end
