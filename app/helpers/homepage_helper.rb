module HomepageHelper

  def total_pages_of_page(pages)
    WillPaginate::ViewHelpers.total_pages_for_collection(pages)
  end
end
