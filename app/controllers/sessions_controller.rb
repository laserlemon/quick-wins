class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      cookies[:current_user_id] = user.id
      redirect_to messages_path
    else
      flash.now[:alert] = "Sorry, try again!"
      render :new
    end
  end

  def destroy
    cookies.delete(:current_user_id)
    flash[:success] = "See you later!"
    redirect_to login_path
  end
end
