class CommentsController < ApplicationController
  def show
    @comment = Comment.find_by(id: params[:id])
    render :show  
  end

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id  

    if @comment.save
      flash[:notices] = "Comment saved successfully!"
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
