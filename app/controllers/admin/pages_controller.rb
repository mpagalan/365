class Admin::PagesController < ApplicationController

  def index
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_pages_path
    else
      render :action => :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Page with id #{params[:id]} could not be found"
    redirect_to admin_pages_path
  end

end
