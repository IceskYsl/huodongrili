# coding: utf-8
class Cpanel::BlogsController < Cpanel::BaseController
  def index
    @items = Blog.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 100
  end

end
