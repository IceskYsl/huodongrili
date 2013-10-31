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
   
   IS_CHAT={"不可以被约聊天"=>0,"可以被约聊天"=>1}
   
  field :state, :type => Integer, :default => STATE[:init]
   
  field :login
  field :username
  field :email, :type => String, :default => ""
  field :tagline
  field :bio
  field :avatar
  field :tags, :type => Array, :default => [] #设置标签（“单身求解救”，“吃货”……）
  
  # 聊天者
  field :seq, :type => Integer, :default => 1 #排序，越大的往前
  field :is_chat, :type => Integer, :default => 0
  field :nickname
  field :city
  field :image
  field :locations, :type => Array, :default => [] #设置自己合适的地点（选地图标注，地图比较方便大家查看）
  field :dates, :type => Array, :default => [] #设置自己可行的时间（是个List）
  field :topics #其他设置（喜欢的聊天主题，最近关心的事情等，是文本备注）
  
  field :roles, :type => Array, :default => ["user"]
  

  #社交帐号
  field :website
  field :zhihu
  field :weibo
  field :douban
  field :twitter
  field :facebook
  field :google
  

  
  embeds_many :authorizations
  
  has_many :blogs
  has_many :chats
  
  attr_accessor :location_list,:date_list,:topic_list,:tag_list
  scope :normal, where(:state.gt => STATE[:init])
  scope :can_chat, where(:is_chat.gt => STATE[:init])
  scope :hot, desc('seq')  
  
  
  
  
  def self.chat_collection
      IS_CHAT.collect { |s| [s[0], s[1]]}
  end
  
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"].to_s
    authorizations.create(:provider => provider , :uid => uid )
  end
  

  
  def tag_list
    self.tags.join(" ") if self.tags
  end
  
  def topic_list
    self.topics.join("") if self.topics
  end
  
  def date_list
    self.dates.join(" ") if self.dates
  end
  
  def location_list
    self.locations.join(" ") if self.locations
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