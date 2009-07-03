require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomepageHelper do
  include HomepageHelper
  
  before(:each) do
    @mock_page = mock_model(Page)
    @pages = [@mock_page]
  end

  it "should be included in the objec returned by the #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(HomepageHelper)
  end

  describe "when using total_pages_of_page" do
    before(:each) do
      @pages.stub!(:total_pages).and_return(1)
    end

    it "should  return the an interger value of the total pages" do
      total_pages_of_page(@pages).should == 1
    end
  end
end
