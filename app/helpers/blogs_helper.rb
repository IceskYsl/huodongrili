module BlogsHelper
  
  def blog_tags_tag(blog, opts = {})
    return "" if blog.blank? or blog.tags.blank?
    limit = 5
    tags = blog.tags
    tags = tags[0..limit-1] if tags.count > limit
    raw tags.collect { |tag| link_to(tag,tag_blogs_path(:tag => tag)) }.join(", ")
  end
  
  
end
