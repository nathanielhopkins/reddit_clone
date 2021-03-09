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

  def upvote
    @vote = Vote.find_or_create_by(user_id: current_user.id, votable_type: "Comment", votable_id: params[:id])
    if @vote.value.nil? || @vote.value == -1
      @vote.value = 1
      @vote.save
    end
    redirect_to comment_url(params[:id])
  end

  def downvote
    @vote = Vote.find_or_create_by(user_id: current_user.id, votable_type: "Comment", votable_id: params[:id])
    if @vote.value.nil? || @vote.value == 1
      @vote.value = -1
      @vote.save
    end
    redirect_to comment_url(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
