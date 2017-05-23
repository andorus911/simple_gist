require 'spec_helper'

describe Snippet do

  let(:user) { FactoryGirl.create(:user) }

  before { @snippet = user.snippets.build(title: "Hello.rb", content: "puts \"Hello, world!\"") }

  subject { @snippet }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  it "its :user should be equal to user" do
    expect(subject.user).to eq user
  end

  it { should be_valid }

  describe "when user_id is not present" do
    before { @snippet.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @snippet.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @snippet.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @snippet.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @snippet.content = "a" * 3001 }
    it { should_not be_valid }
  end

  describe "comment associations" do
    before { @snippet.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, user_id: @snippet.user_id, snippet: @snippet, created_at: 1.day.ago, content: "something")
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, user_id: @snippet.user_id, snippet: @snippet, created_at: 1.hour.ago, content: "something else")
    end

    it { should have_content(older_comment.content) }
    it { should have_content(newer_comment.content) }

    it "should have the right comments in the right order" do
      expect(@snippet.comments.to_a).to eq [newer_comment, older_comment]
    end

    it "should destroy associated comments" do
      comments = @snippet.comments.to_a
      @snippet.destroy
      expect(comments).not_to be_empty
      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end
end