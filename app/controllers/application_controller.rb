class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_account
    return nil unless session[:account_id]
    @current_account ||= Account.find(session[:account_id])
  end
  
  def require_account
    redirect_to(login_accounts_path, :notice => '需要登录才可以进进行操作.') unless current_account
  end
  
end
