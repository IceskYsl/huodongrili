# coding: utf-8
class Chat
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  
  STATE = {
     :delete => -2, #删除
     :draft => -1, #隐藏
     :init => 0, #初始化
     :normal => 1#基本信息确认过（配图）
   }
   
  field :title #文章标题
  field :account_id #摘要
  field :user_id #摘要
  
  field :location
  field :date
  field :topic #其他设置（喜欢的聊天主题，最近关心的事情等，是文本备注）

  
  belongs_to :account
  
  
end