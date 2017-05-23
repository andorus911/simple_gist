class SnippetsController < ApplicationController
  before_action :signed_in_user # ATTENTION ON THIS!

  def create
    @snippet = current_user.snippets.build(snippet_params)
    if @snippet.save
      flash[:success] = "Snippet created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def destroy
  end

  private

    def snippet_params
      params.require(:snippet).permit(:title, :content)
    end
end