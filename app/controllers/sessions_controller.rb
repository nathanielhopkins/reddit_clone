class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = "Username and password are incorrect."
      render :new
    else
      login_user!(user)
      flash[:notices] = "Successfully logged in as #{user.username}!"
      redirect_to root_path
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    flash[:notices] = "Successfully logged out!"

    redirect_to new_session_url
  end
end
