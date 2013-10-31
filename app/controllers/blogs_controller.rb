# coding: utf-8
class BlogsController < ApplicationController
  before_filter :require_account,:only=>[:new,:create,:edit,:update]
  
  def index
    page = params[:page] || 1
    scoped_items = Blog.normal
    @items = scoped_items.recent.paginate(:page => page, :per_page => 100)
  end
  
  def show
    @blog = Blog.unscoped.find(params[:id])
  end
  
  def new
    @blog = Blog.new()
  end
  
  def create
    params.permit!
    @blog = Blog.new(params[:blog])
    @blog.account_id =  session[:account_id]
    if @blog.save
      redirect_to(blogs_path, :notice => '故事添加成功,谢谢.')
    else
      redirect_to new_blog_path,:notice => '故事保存的时候出错了.'
    end
  end
  
  def edit
    @blog = Blog.unscoped.find(params[:id])
  end
  
  def update
    @blog = Blog.unscoped.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to(blogs_path, :notice => '故事编辑成功～')
    else
      render :action => "edit",:id=>params[:id]
    end
  end
  
end
