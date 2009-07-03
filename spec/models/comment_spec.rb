require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    Comment.create(:name => "marjun", :email => "example@test.com", :description => "this is a comment", :page_id => 7)
  end

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:description)}
  
  it "should not create without any value" do
    Comment.new.save.should be_false
  end
end
