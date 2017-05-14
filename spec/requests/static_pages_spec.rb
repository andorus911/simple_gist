require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    before(:each) do
      visit '/static_pages/home'
    end

    it "should have the content 'Simple Gist'" do
      expect(page).to have_content('Simple Gist')
    end

    it "should have the right title" do
      expect(page).to have_title('Simple Gist | Home')
    end
  end

  describe "Help page" do
    before(:each) do
      visit '/static_pages/help'
    end

    it "should have the developer mail address" do
      expect(page).to have_link('me', :href=>'mailto:andorus911@gmail.com')
    end

    it "should have the right title" do
      expect(page).to have_title('Simple Gist | Help')
    end
  end

  describe "About page" do
    before(:each) do
      visit '/static_pages/about'
    end

    it "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end

    it "should have the right title" do
      expect(page).to have_title('Simple Gist | About')
    end
  end
end
