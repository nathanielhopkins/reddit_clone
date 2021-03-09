class PostsController < ApplicationController
  before_action :require_author!, only: [:edit, :update]

  def show
    @post = Post.find_by(id: params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    
    if @post.save
      flash[:notices] = "#{@post.title} posted successfully."
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update_attributes(post_params)
      flash[:notices] = "Post updated successfully."
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def upvote
    @vote = Vote.find_or_create_by(user_id: current_user.id, votable_type: "Post", votable_id: params[:id])
    if @vote.value.nil? || @vote.value == -1
      @vote.value = 1
      @vote.save
    end
    redirect_to post_url(params[:id])
  end

  def downvote
    @vote = Vote.find_or_create_by(user_id: current_user.id, votable_type: "Post", votable_id: params[:id])
    if @vote.value.nil? || @vote.value == 1
      @vote.value = -1
      @vote.save
    end
    redirect_to post_url(params[:id])
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end

  def require_author!
    @post = Post.find_by(id: params[:id])
    redirect_to post_url(@post) unless @post.author_id == current_user.id
  end
end
