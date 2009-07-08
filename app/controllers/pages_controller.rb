class PagesController < ApplicationController
#  caches_page :index
  cache_sweeper :page_sweeper, :only => [:index]
  
  def index
    @pages = Page.paginate(:page => params[:page])

    respond_to do |format|
      format.html #render .html template
      format.js #render .js template
    end
  end
end
