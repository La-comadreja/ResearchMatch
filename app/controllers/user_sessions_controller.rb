class UserSessionsController < ApplicationController
  def new
    redirect_to profile_path
  end

  def destroy
    @user_session.destroy if @user_session
    @user_session = nil
    @current_user = nil
    flash[:notice] = "Logged out successfully"
    redirect_to home_path
  end
end
