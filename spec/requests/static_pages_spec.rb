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
      let!(:snippet) do
        FactoryGirl.create(:snippet, user: FactoryGirl.create(:user))
      end

      it { should have_link(snippet.title, href: snippet_path(snippet)) } # Smthng wrong...
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
