class CommentsController < ApplicationController
  cache_sweeper PageSweeper, :only => [:create]
  
  before_filter :set_current_page, :only => [:index, :create]
  helper_method :current_page

  def index
    @comments = current_page.comments

    respond_to do |format|
      format.js #render .js template
    end
  end

  def create
    respond_to do |format|
      @comment = current_page.comments.create(params[:comment])
      if @comment.valid?
        format.js #render .js template
      else
        format.js {render("comments/create_error")}
      end
    end
  end

  protected
  def set_current_page
    @page = Page.find(params[:page_id], :include => :comments)
  end

  def current_page
    @page
  end
end
