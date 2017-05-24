class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy] # ATTENTION ON THIS!
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @comment.snippet
    else
      redirect_to root_url
    end
  end

  def destroy
    snippet = @comment.snippet
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to snippet
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :snippet_id)
    end

    def correct_user
      if current_user.admin?
        @comment = Comment.find_by(id: params[:id])
      else
        @comment = current_user.snippets.find_by(id: params[:id])
      end
    rescue
      redirect_to root_url
    end
end