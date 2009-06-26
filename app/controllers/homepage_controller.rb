class HomepageController < ApplicationController
#  caches_page :index
  cache_sweeper :page_sweeper, :only => [:index]
  
  def index
    @pages = Page.paginate(:page => params[:page])
  end
end
