# coding: utf-8
class ChatsController < ApplicationController
  before_filter :require_account,:only=>[:create,:confirm,:update]
  
  def index
    page = params[:page] || 1
    scoped_items = Account.can_chat
    @items = scoped_items.recent.hot.paginate(:page => page, :per_page => 100)
  end
  
  def waterfall
    page = params[:page] || 1
    scoped_items = Account.can_chat
    @items = scoped_items.recent.hot.paginate(:page => page, :per_page => 100)
  end
  
 
  def create
    params.permit!
    @chat = Chat.new(params[:chat])
    @chat.account_id =  params[:chat][:account_id]
    @chat.user_id = session[:account_id]
    if @chat.save
      redirect_to(root_path, :notice => '约聊天信息已经发出，等待确认.')
    else
      redirect_to account_path(params[:account_id]),:notice => '约聊天失败.'
    end
  end
  
  #确认
  def confirm
    @chat = Chat.find(params[:id])  
    unless (@chat && @chat.account_id == session[:account_id].to_i)
      redirect_to(root_path, :notice => '你不能看到别人的聊天请求 :)')
    end
  end
  
  def update
    @chat = Chat.find(params[:id])  
    unless (@chat && @chat.account_id == session[:account_id].to_i)
      redirect_to(root_path, :notice => '你不能看到别人的聊天请求 :)')
    end
    @chat.state = 1
    @chat.save
    @chat.send_confirm_mail
    redirect_to(root_path, :notice => '聊天申请已经确认，记得准时赴约.')
  end
  
end
