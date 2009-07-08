require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController, "routes" do
  
  it "should map #index" do
    route_for(:controller => "pages",
              :action => "index").should == "/pages"
  end
end

describe "PagesController in general", :shared => true do
  
  before(:each) do
    @mock_page = mock_model(Page)
    Page.stub!(:paginate).and_return([@mock_page])
  end

end

describe PagesController, "on viewing pages" do
  it_should_behave_like "PagesController in general"

  def do_request
    get :index
  end

  it "should render the page successfully" do
    do_request
    response.should be_success
  end

  it "should render the index template" do
    do_request
    response.should render_template('index')
  end

  it "should find the latest pages" do
    do_request
    assigns[:pages].should == [@mock_page]
  end

  describe "with js format" do
    def do_request
      get :index , :format => "js"
    end

    it "should render the index.js page" do
      do_request
      params[:format].should == "js"
      response.should render_template('index')
    end

    it "should render the page successfully" do
      do_request
      response.should be_success
    end
  end
end
