class StaticPagesController < ApplicationController
  def home
    @snippet = current_user.snippets.build if signed_in?
    @discover = Snippet.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
