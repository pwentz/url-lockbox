class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email_address: params[:session][:email_address])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to links_path
    else
      flash[:danger] = 'Invalid login credentials'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
