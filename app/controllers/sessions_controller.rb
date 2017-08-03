class SessionsController < ApplicationController

  def new
    @session = Session.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      @session[:user_id] = @user.id
      redirect_to [:products], notice: 'Logged in'
    else
      redirect_to [:sessions, :new]
    end
  end

  def destory
    @session[user_id] = nil
    redirect_to [:sessions, :new]
  end

end
