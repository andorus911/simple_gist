require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Simple Gist" }

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Simple Gist') }
    it { should have_title("#{base_title} | Home") }

    describe "discover" do
      let(:user) { FactoryGirl.create(:user) }
      let(:first_snippet) do
        FactoryGirl.create(:snippet, user: FactoryGirl.create(:user))
      end
      let(:second_snippet) do
        FactoryGirl.create(:snippet, user: FactoryGirl.create(:user))
      end

      it "should have some messages" do
        expect(:discover).to { should include(first_snippet) }
        expect(:discover).to { should include(second_snippet) }
      end

      describe "with signed in user" do # Not existing big 'Simple Gist' table
        before { sign_in user }

        it { should have_content("Compose new snippet...") }
        it { should_not have_content('Sign Up') }
      end

      describe "with unsigned in user" do
        before { visit signout_path }

        it { should have_content('Sign Up') }
        it { should_not have_content("Compose new snippet...") }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_link('me', :href=>'mailto:andorus911@gmail.com') }
    it { should have_content('Help') }
    it { should have_title("#{base_title} | Help") }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title("#{base_title} | About") }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_link('Gmail', :href=>'mailto:andorus911@gmail.com') }
    it { should have_link('Skype', :href=>'skype:andorus911?chat') }
    it { should have_content('Contact') }
    it { should have_title("#{base_title} | Contact") }
  end
end
