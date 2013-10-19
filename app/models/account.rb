# coding: utf-8
require "securerandom"
require "digest/md5"
require "open-uri"
class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  extend OmniauthCallbacks
  
  
  STATE = {
     :delete => -2, #暂停
     :draft => -1, #隐身
     :init => 0, #初始化
     :normal => 1#可聊天（配图）
   }
   
  field :login
  field :username
  field :email, :type => String, :default => ""
  field :tagline
  field :bio
  field :avatar
  field :tags, :type => Array, :default => ["user"] #设置标签（“单身求解救”，“吃货”……）
  
  # 聊天者
  field :state, :type => Integer, :default => STATE[:init]
  field :image
  field :locations, :type => Array, :default => [] #设置自己合适的地点（选地图标注，地图比较方便大家查看）
  field :dates, :type => Array, :default => [] #设置自己可行的时间（是个List）
  field :topics #其他设置（喜欢的聊天主题，最近关心的事情等，是文本备注）
  
  field :roles, :type => Array, :default => ["user"]
  

  #社交帐号
  field :zhihu
  field :weibo
  field :douban
  field :twitter
  field :facebook
  field :google
  
  embeds_many :authorizations
  
  has_many :blogs
  has_many :chats
  
  
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"].to_s
    authorizations.create(:provider => provider , :uid => uid )
  end
  
  #role
  def has_role?(role)
    self.roles.include?(role)
  end
  
  def add_role(role)
    self.push(:roles, role)
  end
  
  def del_role(role)
    self.pull(:roles, role)
  end
  
end