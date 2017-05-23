require 'spec_helper'

describe "Snippet pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "snippet creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a snippet" do
        expect { click_button "Snip it" }.not_to change(Snippet, :count)
      end

      describe "error messages" do
        before { click_button "Snip it" }
        
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do 
        fill_in 'snippet_title', with: "Latin" 
        fill_in 'snippet_content', with: "Lorem ipsum"
      end

      it "should create a snippet" do
        expect { click_button "Snip it" }.to change(Snippet, :count).by(1)
      end

      describe "created link to Snippet page" do
        before { click_button "Snip it" }

        it { should have_link("Latin", href: snippet_path(1)) }
      end
    end
  end

  describe "snippet destruction" do
    before { FactoryGirl.create(:snippet, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a snippet" do
        expect { click_link "delete" }.to change(Snippet, :count).by(-1)
      end
    end
  end

  describe "snippet showing" do
    let(:snippet) { FactoryGirl.create(:snippet, user: user) }
    before { visit snippet_path(snippet) }

    it { should have_link('you', href: user_path(user)) }
    it { should have_title(snippet.title) }
    it { should have_content(snippet.content) }
  end
end