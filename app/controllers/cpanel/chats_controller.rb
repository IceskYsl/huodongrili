# coding: utf-8
class Cpanel::ChatsController < Cpanel::BaseController
  def index
    @items = Chat.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 100    
  end
end
