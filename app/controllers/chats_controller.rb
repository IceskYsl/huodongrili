# coding: utf-8
class ChatsController < ApplicationController
  
  def index
    page = params[:page] || 1
    scoped_items = Chat.normal
    @chats = scoped_items.recent.paginate(:page => page, :per_page => 100)
  end
  
  #申请聊天
  def apply
    @chat = Chat.find(params[:id])
  end
  
  #确认
  def confirm
    @chat = Chat.find(params[:id])    
  end
  
end
