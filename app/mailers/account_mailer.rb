# coding: utf-8
class AccountMailer < BaseMailer

  def apply(chat_id)
    @chat = Chat.find(chat_id)
    @account = Account.find_by_id(@chat.account_id)
    @user = Account.find_by_id(@chat.user_id)
    return false if (@account.blank? || @user.blank?)
    mail(:to => @account.email, :subject => "有人约聊天啦~", :app_name => "活动日历")
  end
  
  def confirm(chat_id)
    @chat = Chat.find(chat_id)
    @account = Account.find_by_id(@chat.account_id)
    @user = Account.find_by_id(@chat.user_id)
    return false if (@account.blank? || @user.blank?)
    mail(:to => @user.email, :subject => "聊天申请通过啦，准备聊天吧~", :app_name => "活动日历")
  end
  
end