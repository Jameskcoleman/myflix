class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        redirect_to home_path, success: 'You are signed in.'
      else
        flash[:danger] = "Your account has been suspended. Please contact customer support."
        redirect_to sign_in_path
      end
    else
      flash[:danger] = "Invalid email or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, success: "You are signed out."
  end
end