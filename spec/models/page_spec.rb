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

end
