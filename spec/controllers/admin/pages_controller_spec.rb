require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PagesController, "routes" do

  it "should map #index" do
    route_for(:controller => "admin/pages",
              :action => "index").should == "/admin/pages"
  end

  it "should map #new" do
    route_for(:controller => "admin/pages",
              :action => "new").should == "/admin/pages/new"
  end

  it "should map #show" do
    route_for(:controller => "admin/pages",
              :action => "show", :id => "1").should == "/admin/pages/1"
  end

  it "should map #edit" do
    route_for(:controller => "admin/pages",
              :action => "edit", :id => "1").should == "/admin/pages/1/edit"
  end

  it "should map #update" do
    route_for(:controller => "admin/pages",
              :action => "update", :id => "1").should == { :path => "/admin/pages/1", :method => :put }
  end

  it "should map #destroy" do
    route_for(:controller => "admin/pages",
              :action => "destroy", :id => "1").should == { :path => "/admin/pages/1", :method => :delete }
  end

end

describe "Admin::PagesController in general", :shared => true do
  include ImageHelper
  
  before do
    @mock_page = mock_model(Page)
    Page.stub!(:new).and_return(@mock_page)
    @params = {}
  end

end

describe Admin::PagesController, "on view pages" do
  it_should_behave_like "Admin::PagesController in general"

  before(:each) do
    Page.stub!(:find).with(:all).and_return([@mock_page])
  end

  def do_request
    get :index
  end

  it "should find all pages" do
    do_request
    assigns[:pages].should == [@mock_page]
  end

  it "should render the pages list" do
    do_request
    response.should render_template('admin/pages/index')
  end

  it "should be succesfull" do
    do_request
    response.should be_success
  end

end

describe Admin::PagesController, "on new page" do
  it_should_behave_like "Admin::PagesController in general"


  def do_request
    get :new
  end
  
  it "should be succesful" do
    do_request
    response.should be_success
  end

  it "should render new page form" do
    do_request
    response.should render_template('admin/pages/new')
  end

  it "should initialize new page instance varible" do
    do_request
    assigns[:page].should_not be_nil
  end
end

describe Admin::PagesController, "on page creation" do
  it_should_behave_like "Admin::PagesController in general"
  
  before(:each) do
    @mock_page.stub!(:save).and_return(true)
    @params = {:page => { :title => "landscape", :description => "the dog is over the cat",
                         :published_on => 1.days.ago, :image => image }}
  end

  def do_request
    post :create, @params
  end

  it "should redirect to the index page" do
    do_request
    response.should redirect_to(admin_pages_path)
  end
  
  describe "when save fails" do
    before(:each) do
      @mock_page.stub(:save).and_return(false)
    end

    it "should render the new page form" do
      do_request
      response.should render_template('admin/pages/new')
    end

  end
end

describe Admin::PagesController, "on page edit" do
  it_should_behave_like "Admin::PagesController in general"

  before(:each) do
    Page.stub!(:find).with("7").and_return(@mock_page)
  end

  def do_request
    get :edit, :id => "7"
  end

  it "should find the page for editing" do
    do_request
    assigns[:page].should_not be_nil
  end

  it "should render the edit page form" do
    do_request
    response.should render_template('admin/pages/edit')
  end

  describe "when record not found" do
    before(:each) do
      Page.stub!(:find).with("7").and_raise(ActiveRecord::RecordNotFound)
    end

    it "should redirect to admin pages" do
      do_request
      response.should redirect_to admin_pages_path
    end

    it "should flash error" do
      do_request
      flash[:error].should =~ /could not be found/
    end
  end
end

describe Admin::PagesController, "on page update" do
  it_should_behave_like "Admin::PagesController in general"
  
  before(:each) do
    @params = {:page => {:title => "sunset", :published_on => 2.days.ago, :image => image} , :id => "7"}
    Page.stub!(:find).with("7").and_return(@mock_page)
    @mock_page.stub!(:update_attributes).and_return(true)
  end

  def do_request
    get :update, @params
  end

  it "should find the page for updating" do
    do_request
    assigns[:page].should_not be_nil
  end

  it "should update the page and redirect to show page" do
    do_request
    response.should redirect_to(admin_page_path(@mock_page))
  end

  describe "when record not found" do
    before(:each) do
      Page.stub!(:find).with("7").and_raise(ActiveRecord::RecordNotFound)
    end

    it "should redirect to admin pages" do
      do_request
      response.should redirect_to admin_pages_path
    end

    it "should flash error" do
      do_request
      flash[:error].should =~ /could not be found/
    end
  end

  describe "when update is not successful" do
    before(:each) do
      @mock_page.stub!(:update_attributes).and_return(false)
    end
  
    it "should render the edit page form" do
      do_request
      response.should render_template('admin/pages/edit')
    end
  end
end

describe Admin::PagesController, "on page show" do
  it_should_behave_like "Admin::PagesController in general"

  before(:each) do
    Page.stub!(:find).with("7").and_return(@mock_page)
  end

  def do_request
    get :show, :id => "7"
  end

  it "should find the page" do
    do_request
    assigns[:page].should_not be_nil
  end

  it "should render the show page template" do
    do_request
    response.should render_template('admin/pages/show')
  end

  describe "when page record is not found" do
    before(:each) do
      Page.stub!(:find).with("7").and_raise(ActiveRecord::RecordNotFound)
    end

    it "should redirect to admin pages" do
      do_request
      response.should redirect_to admin_pages_path
    end

    it "should flash error saying 'page could not be found'" do
      do_request
      flash[:error].should =~ /could not be found/
    end
  end
end
