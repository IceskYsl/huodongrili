class Cpanel::AccountsController < Cpanel::BaseController
  def index
    @items = Account.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 100
  end
end
