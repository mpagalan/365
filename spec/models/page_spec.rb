require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')



describe Page do
  include ImageHelper
  include MusicHelper
  before(:each) do
     Page.create(:title => "shot", :published_on => 20.day.ago, :image =>image)
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:published_on)}
  it { should validate_uniqueness_of(:published_on)}
  
  it "should not create without any value" do
    Page.new.save.should be_false
  end
 
  it "should not have an error when assigned a valid image " do
    page = Page.new(:title => "shot", :published_on => 1.day.ago, :image =>image)
    page.save
    page.errors.on(:image).should be_nil
  end
  
  it "should be able to accept image file" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>image).save.should be_true
  end
  
  it "should not accept bad images with image extensions" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>bad_image).save.should be_false
  end
  
  it "should not accept non image types" do
    Page.new(:title => "shot", :published_on => 1.day.ago, :image =>text_file).save.should be_false
  end

  it "should not have an error when assigned a valid music " do
    page = Page.new(:title => "shot", :published_on => 1.day.ago, :image =>image, :music => music)
    page.save
    page.errors.on(:music).should be_nil
  end
  
  it "should be able to accept music file" do
    Page.new(:title => "vibes", :published_on => 1.day.ago, :image => image, :music => music).save.should be_true
  end

  it "should not accept non music/mp3 type" do
    Page.new(:title => "vibes", :published_on => 1.day.ago, :image => image, :music => text_file).save.should be_false
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
    @test_page.image.send(:styles)[:fullimage].should == ["x1024", nil]
    @test_page.image.send(:styles)[:thumb].should == ["150x150>", nil]
  end
end

describe Page, "with music" do
  include MusicHelper
  include ImageHelper

  before(:each) do
    @test_page = Page.new(:title => "shot", :published_on => 1.day.ago, :image => image, :music => music)
    @test_page.save
  end

  it "should return the proper path of the mp3" do
    @test_page.current_state.should == :converted
    @test_page.music.path.should == "#{RAILS_ROOT}/public/#{RAILS_ENV}/pages/musics/#{@test_page.id}/#{@test_page.music.basename}.mp3"
  end

  it "should return the proper url of the flv" do
    @test_page.current_state.should == :converted
    @test_page.music.url.include?("/#{RAILS_ENV}/pages/musics/#{@test_page.id}/#{@test_page.music.basename}.mp3").should be_true
  end

  it "should convert the mp3 to flv" do
    @test_page.current_state.should_not == :pending
  end

  it "should have an flv extension name" do
    @test_page.music.original_filename.should =~ /.mp3/
  end

  it "should have a state" do
    @test_page.current_state.should_not == :pending
    @test_page.current_state.should_not == :error
  end
end
