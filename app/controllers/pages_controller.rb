class PagesController < ApplicationController
  cache_sweeper PageSweeper, :only => [:index]
  
  def index
    #@pages = Page.paginate(:page => params[:page], :include => :comments)
    @pages = Page.find(:all , :include => :comments)
    respond_to do |format|
      format.html #render .html template
      format.js #render .js template
    end
  end
end
