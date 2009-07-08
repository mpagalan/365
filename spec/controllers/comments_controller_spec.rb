require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController, "routes" do
  
  it "should map #index" do
    route_for(:controller => "comments",
              :action => "index", :page_id => "7").should == "/pages/7/comments"
  end
  
  it "should map #create" do
    route_for(:controller => "comments",
              :action => "create", :page_id => "7").should == { :path => "/pages/7/comments", :method => :post }
  end
end

describe "CommentsController in general", :shared => true do
  
  before(:each) do
    @mock_page = mock_model(Page)
    @mock_comment = mock_model(Comment)
    Page.stub(:find).with("7").and_return(@mock_page)
    @mock_comments_proxy = [@mock_comment]
    @mock_page.stub(:comments).and_return(@mock_comments_proxy)
  end

end

describe CommentsController, "on viewing comments" do
  it_should_behave_like "CommentsController in general"

  describe "with js format" do
    def do_request
      get :index, :page_id => 7, :format => "js"
    end

    it "should render successfully" do
      do_request
      response.should be_success
    end

    it "should render the index.js template" do
      do_request
      params[:format].should == "js"
      response.should render_template('index')
    end

    it "should find the page" do
      do_request
      assigns[:page].should == @mock_page
    end
  end

end

describe CommentsController, "on creating comments" do
  it_should_behave_like "CommentsController in general"
  
  before(:each) do
    @mock_new_comment = mock_model(Comment, :valid? => true)
    @mock_comments_proxy.stub(:create).and_return(@mock_new_comment)
  end
  
  def comment_params(options={})
    {:name => "365fan", :email => "365fan@test.com", :decription => "luv it"}.merge(options)
  end
  
  describe "with js format" do
    def do_request
      post :create, :page_id => 7, :comment => comment_params, :format => "js"
    end

    it "should find the page" do
      do_request
      assigns[:page].should == @mock_page
    end

    it "should render successfully" do
      do_request
      response.should be_success
    end

    it "should render the create.js template" do
      do_request
      params[:format].should == "js"
      response.should render_template('create')
    end
    
    describe "when create comment failed" do
      before(:each) do
        @mock_new_comment.stub(:valid?).and_return(false)
      end

      def do_request
        post :create, :page_id => 7, :comment => comment_params({:email => nil}), :format => "js"
      end

      it "should render the create_error.js template" do
        do_request
        response.should render_template('create_error')
      end
    end
  end
end
