class CommentsController < ApplicationController
  before_filter :set_quote, only: [:new, :create]
  def create
  	@comment = @quote.comments.build comment_params.merge(user:current_user)
  	respond_to do |format|
      if @comment.save
      	format.html { redirect_to request.referrer }
      else
      	format.html { redirect_to request.referrer }
      end
    end
  end
  private
  def comment_params
  	params.require(:comment).permit(:body)
  end
  def set_comment
  	@comment = Comment.find(params[:id])
  end
  def set_quote
  	@quote = Quote.find(params[:quote_id])
  end
end
