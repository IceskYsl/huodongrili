# coding: utf-8
class BaseMailer < ActionMailer::Base
  default :from => 'service@huodongrili.com'
  default :charset => "utf-8"
  default :content_type => "text/html"
  default_url_options[:host] = "www.huodongrili.com"

  layout 'mailer'
  helper :accounts
end