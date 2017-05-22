require 'spec_helper'

describe "Snippet pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "snippet creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a snippet" do
        expect { click_button "Post" }.not_to change(Snippet, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do 
        fill_in 'snippet_title', with: "Latin" 
        fill_in 'snippet_content', with: "Lorem ipsum"
      end

      it "should create a snippet" do
        expect { click_button "Post" }.to change(Snippet, :count).by(1)
      end
    end
  end
end