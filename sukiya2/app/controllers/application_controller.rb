class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_current_date

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def set_current_date
    @current_date = Date.current
    @current_date_sum = @current_date.year*10000 + @current_date.month*100 + @current_date.day
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
