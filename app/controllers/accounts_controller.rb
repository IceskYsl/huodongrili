# coding: utf-8
class AccountsController < ApplicationController
  before_filter :require_account,:only=>[:profile]

  #聊天人列表
  def index
  end
  
  #得到自己独一无二link  www.huodongrili.com/u/username
  def show
  end
  
  def profile
    
  end
  
  def edit
    @account = current_account
  end
  
  def update
  end
  
  
  #采用Google账号登陆
  def bind
    response = request.env["omniauth.auth"]
    provider = response["provider"].to_s
    uid = response["uid"].to_s
    logger.info "==bind::=====provider:#{provider}----response:#{response}======="
    unless current_account.blank?
      current_account.bind_service(response) #Add an auth to existing
      redirect_to(root_path, :notice => "成功绑定了 #{provider} 帐号。")        
    else
      @account = Account.find_or_create_for_google(response)
      if @account.persisted?
        set_session
        flash[:notice] = "Signed in with #{provider.to_s.titleize} successfully."
        redirect_to(root_path)        
      else
        flash[:notice] = "登录失败，请检查你的key是否输入正确."
        redirect_to(root_path)    
      end
    end
  end

  def set_session
    if @account
      session[:account_id] = @account.id
      session[:account_username] = @account.username
    else
      session[:account_id] = nil
      session[:account_username] = nil    
    end
  end
  
  #登出
  def logout
    session[:account_id] = nil
    session[:account_username] = nil    
    redirect_to(root_path, :notice => '登出成功，欢迎下次再来.')
  end
  
  #帐号设置
  def setting
    
  end
  
end
