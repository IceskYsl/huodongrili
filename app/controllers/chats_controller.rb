# coding: utf-8
class ChatsController < ApplicationController
  
  def index
    page = params[:page] || 1
    scoped_items = Account.can_chat
    @items = scoped_items.recent.paginate(:page => page, :per_page => 100)
  end
  
 
  def create
    params.permit!
    @chat = Chat.new(params[:chat])
    @chat.account_id =  params[:account_id]
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
  end
  
end
