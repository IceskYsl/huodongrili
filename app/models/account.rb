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
  field :tags, :type => Array, :default => [] #设置标签（“单身求解救”，“吃货”……）
  
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
  
  attr_accessor :location_list,:date_list,:topic_list
  
  
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"].to_s
    authorizations.create(:provider => provider , :uid => uid )
  end
  
  before_save :split_tags
  def split_tags
    if !self.location_list.blank? and self.locations.blank?
      self.locations = self.location_list.split(/,|，/).collect { |tag| tag.strip }.uniq
    end
    if !self.date_list.blank? and self.dates.blank?
      self.dates = self.date_list.split(/,|，/).collect { |tag| tag.strip }.uniq
    end
    if !self.topic_list.blank? and self.topics.blank?
      self.topics = self.topic_list.split(/,|，/).collect { |tag| tag.strip }.uniq
    end
  end
  
  def topic_list
    self.topics.join(",")
  end
  
  def date_list
    self.dates.join(",")
  end
  
  def location_list
    self.locations.join(",")
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