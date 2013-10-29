# coding: utf-8
class Account
  module OmniauthCallbacks
 
    
    #Google
    def find_or_create_for_google(response)
      provider = response["provider"].to_s
      uid = response["uid"].to_s
      data = response["info"]
      
      #如果已绑定
      if account = Account.where("authorizations.provider" => provider , "authorizations.uid" => uid).first
        account
      #如果有帐号，则绑定
      elsif account = Account.where(:email => data["email"]).first
        account.authorizations << Authorization.new(:provider => provider, :uid => uid )
        account
      #创建帐号和绑定  
      else
        account = Account.new do |account|
          account.email = data["email"].present?  ?  data["email"] : "#{provider}+#{uid}@tagskill.com"
          account.login = data["email"]
          account.username = data['name']
          account.nickname = data['name']
          account.avatar = data["image"]
        end
        if account.save(:validate => false)
          account.authorizations << Authorization.new(:provider => provider, :uid => uid )
          return account
        else
          Rails.logger.warn("Account.create_from_hash 失败，#{account.errors.inspect}")
          return nil
        end
      end
    end # end find_or_create_for_google
    
 
    
  end
end