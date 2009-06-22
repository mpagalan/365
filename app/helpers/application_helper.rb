# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def page_title
    "365"
  end
  
  def format_date(date)
    return nil unless date
    @date_format ||= '%b %d, %Y' #this could be comming from the user setting preferences
    date.strftime(@date_format)
  end

end
