class PageSweeper < ActionController::Caching::Sweeper
  observe Page, Comment

  def after_save(record)
    expire_cache_for(record)
  end

  def after_destroy(record)
    expire_cache_for(record)
  end

  private
  # add the record object for future use
  def expire_cache_for(record)
    case record
    when Page
      expire_page_caches(record.id)
    when Comment
      expire_page(:controller => 'pages', :action => 'index', :page_id => record.page_id, :on => "comments")
    end
  end

  def expire_page_caches(page_id)
    expire_page(:controller => 'pages', :action => 'index', :page_id => page_id)
  end
  
end
