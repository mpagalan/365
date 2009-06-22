require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')



describe Page do
  include ImageHelper

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:published_on)}
  
  it "should not create without any value" do
    Page.new.save.should be_false
  end
 
  it "should not have an error when assigned a valid image " do
    page = Page.new(:title => "shot", :published_on => 1.day.ago, :image =>image)
    page.save
    debug_objects(page)
    page.errors.on(:image).should be_nil
  end
  
  it "should be able to accept image file" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>image).save.should be_true
  end
  
  it "should not accept bad images with image extensions" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>bad_image).save.should be_false
  end
  
  it "should not accept none image types" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>text_file).save.should be_false
  end

  it "should have a latest named_scope, with the correct options" do
    expected_options = {:order => "published_on DESC", :limit => 5}
    expected_options.should == Page.latest.proxy_options
  end
end

describe Page, "with image" do
  include ImageHelper
  
  before(:each) do
    @test_page = Page.new(:title => "shot", :published_on => 1.day.ago, :image => image)
    @test_page.save
  end


  it "should return the proper path of the image" do
    @test_page.image.path.should == "#{RAILS_ROOT}/public/#{RAILS_ENV}/pages/images/#{@test_page.id}/fullimage_#{@test_page.image_file_name}"
  end

  it "should return the proper url of the image" do
    @test_page.image.url.include?("/#{RAILS_ENV}/pages/images/#{@test_page.id}/fullimage_#{@test_page.image_file_name}").should be_true
  end

  it "should report the correct styles of the image" do
    @test_page.image.send(:styles)[:fullimage].should == ["1024x677", nil]
    @test_page.image.send(:styles)[:thumb].should == ["150x150#", nil]
  end
end
