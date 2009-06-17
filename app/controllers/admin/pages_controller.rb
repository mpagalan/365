class Admin::PagesController < ApplicationController

  def index
    @pages = Page.find(:all)
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

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to admin_page_path(@page)
    else
      render :action => :edit
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Page with id #{params[:id]} could not be found"
    redirect_to admin_pages_path
  end
end
