# coding: utf-8
class Cpanel::BaseController < ApplicationController
   layout "cpanel"
   before_filter :require_admin
   
   protected

   def require_admin
      authenticate_or_request_with_http_basic do |username, password|
          username == "zoe" && password == "huodongrili"
       end
   end
   
end
