# coding: utf-8
class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  
  STATE = {
     :delete => -2, #删除
     :draft => -1, #隐藏
     :init => 0, #初始化
     :normal => 1#基本信息确认过（配图）
   }
   
  field :title #文章标题
  field :image #文章配图
  field :lede #摘要
  field :body #文章
  field :body_html #文章
  field :tags, :type => Array, :default => [] #设置标签（“单身求解救”，“吃货”……）
  field :state, :type => Integer, :default => STATE[:normal]
  
  attr_accessor :tag_list
  
  #counts
  field :view_count, :type => Integer, :default => 0
  
  
  belongs_to :account
  belongs_to :chat
  
  #scope
  scope :normal, where(:state.gt => STATE[:init])
  scope :by_account, Proc.new { |t| where(:account_id => t) }
  scope :by_tag, Proc.new { |t| where(:tags => t) }
 
  def tag_list
    self.tags.join(" ") if self.tags
  end
  
  def hits_incr
    self.update_attribute(:view_count,self.view_count + 1) 
  end
  

  
  before_save :markdown_for_body_html
    def markdown_for_body_html
      return true if not self.body_changed?

      self.body_html = MarkdownConverter.convert(self.body)
    rescue => e
      Rails.logger.error("markdown_for_body_html failed: #{e}")
    end
    
  
end