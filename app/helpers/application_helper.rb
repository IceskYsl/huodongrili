module ApplicationHelper
  
  def current_account
    return nil unless session[:account_id]
    @current_account ||= Account.find(session[:account_id])
  end
  
  def is_current(c,cc)
    return "active" if c == cc
  end
end
