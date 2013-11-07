class Cpanel::BlogsController < Cpanel::BaseController
  def index
    @blogs = Blog.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 30
  end

end
