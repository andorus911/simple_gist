class SnippetsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy] # ATTENTION ON THIS!
  before_action :correct_user, only: :destroy

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
    @comments = @snippet.comments.paginate(page: params[:page])
  end

  def destroy
    @snippet.destroy
    flash[:success] = "Snippet deleted."
    redirect_to root_url
  end

  private

    def snippet_params
      params.require(:snippet).permit(:title, :content)
    end

    def correct_user
      @snippet = current_user.snippets.find_by(id: params[:id])
    rescue
      redirect_to root_url
    end
end