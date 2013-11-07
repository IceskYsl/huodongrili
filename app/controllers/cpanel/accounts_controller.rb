# coding: utf-8
class Cpanel::AccountsController < Cpanel::BaseController
  def index
    sort = params[:sort]
    case sort
    when "hot"
      @items = Account.unscoped.hot.paginate :page => params[:page], :per_page => 100
    else
      @items = Account.unscoped.recent.paginate :page => params[:page], :per_page => 100
    end
  end
  
  def up
    @account = Account.unscoped.find(params[:id])
    @account.seq = @account.seq + 1
    @account.save
    redirect_to(cpanel_accounts_path, :notice => "你把#{@account.username}往上提了下~")
  end
  
  def down
    @account = Account.unscoped.find(params[:id])
    @account.seq = @account.seq - 1
    @account.save    
    redirect_to(cpanel_accounts_path, :notice => "你把#{@account.username}往下踹了下~")
  end
 
  
end
