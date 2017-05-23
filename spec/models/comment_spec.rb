require 'spec_helper'

describe Comment do

  let(:snippet_author) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:snippet) { FactoryGirl.create(:snippet, user: snippet_author) }
  before { @comment = snippet.comments.build(content: "It is bad, dude", user_id: user.id) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:snippet_id) }
  it "its :user should be equal to user" do
    expect(subject.user_id).to eq user.id
  end

  it { should be_valid }

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when snippet_id is not present" do
    before { @comment.snippet_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @comment.content = "a" * 501 }
    it { should_not be_valid }
  end
end