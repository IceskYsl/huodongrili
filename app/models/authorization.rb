# coding: utf-8
class Authorization
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  #field
  field :provider #weixin,google,github,weibo ect.
  field :uid, type: String
  field :data
  
  embedded_in :account, :inverse_of => :authorizations

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
end