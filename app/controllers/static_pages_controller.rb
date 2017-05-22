class StaticPagesController < ApplicationController
  def home
    @snippet = current_user.snippets.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
