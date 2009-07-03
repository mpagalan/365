require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    Comment.create(:name => "marjun", :email => "example@test.com", :description => "this is a comment", :page_id => 7)
  end

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:page_id)}
  
  it "should not create without any value" do
    Comment.new.save.should be_false
  end

  it "should by default is not a spam" do
    Comment.new().is_spam?.should be_false
  end

  it "should able to mark the comment as spam!" do
    Comment.create(:email => "example@text.com", :description =>"dfdf", :page_id => 7).is_spam!.should be_true
  end
end
