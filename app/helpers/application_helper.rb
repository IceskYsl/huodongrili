module ApplicationHelper
  
  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close","data-dismiss"=>"alert") + message, :class => "alert #{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end
  
  def current_account
    return nil unless session[:account_id]
    @current_account ||= Account.find(session[:account_id])
  end
  
  def is_current(c,cc)
    return "active" if c == cc
  end
end
