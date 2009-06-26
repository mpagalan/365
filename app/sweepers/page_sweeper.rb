class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_save(record)
    expire_cache_for
  end

  def after_destroy(record)
    expire_cache_for
  end

  private
  # add the record object for future use
  def expire_cache_for
    expire_page(:controller => 'homepage', :action => 'index')
  end
end
