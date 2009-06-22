require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomepageController, "routes" do
  
  it "should map #index" do
    route_for(:controller => "homepage",
              :action => "index").should == "/homepage"
  end
end

describe "HomepageController in general", :shared => true do
  
  before(:each) do
    @mock_page = mock_model(Page)
    Page.stub!(:latest).and_return([@mock_page])
  end

end

describe HomepageController, "on viewing pages" do
  it_should_behave_like "HomepageController in general"

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
end
