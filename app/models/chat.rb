# coding: utf-8
class Chat
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  # include Mongoid::MultiParameterAttributes
  
  # include Mongoid::Attributes::Dynamic
  
  STATE = {
     :delete => -2, #删除
     :draft => -1, #隐藏
     :init => 0, #初始化w
     :normal => 1#基本信息确认过（配图）
   }
   
  field :account_id #摘要
  field :user_id #摘要
  
  field :location
  field :when, :type => DateTime
  field :topic #其他设置（喜欢的聊天主题，最近关心的事情等，是文本备注）
  field :body
  field :state, :type => Integer, :default => 0 #STATE

  
  belongs_to :account
  
  # 注册邮件提醒
  after_create :send_apply_mail
  def send_apply_mail
    AccountMailer.apply(self.id).deliver
  end
  
  def send_confirm_mail
    AccountMailer.confirm(self.id).deliver
  end
  
end