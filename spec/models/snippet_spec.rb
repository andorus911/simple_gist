require 'spec_helper'

describe Snippet do

  let(:user) { FactoryGirl.create(:user) }

  before { @snippet = user.snippets.build(title: "Hello.rb", content: "puts \"Hello, world!\"") }

  subject { @snippet }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:user) }
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
end