# coding: utf-8
class Cpanel::BaseController < ApplicationController
   layout "cpanel"
   before_filter :require_admin
   
   protected
   
   def require_admin
     unless current_account && current_account.has_role?("admin")
       redirect_to(root_path, :notice => '你不是管理员.') 
     end
   end
   # def require_admin
   #    authenticate_or_request_with_http_basic do |username, password|
   #        username == "zoe" && password == "qq71681430"
   #     end
   # end
   
end
