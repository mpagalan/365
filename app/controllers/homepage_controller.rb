class HomepageController < ApplicationController
  def index
    @pages = Page.latest
  end
end
