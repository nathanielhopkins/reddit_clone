class SubsController < ApplicationController
  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id 
    
    if @sub.save
      flash[:notices] = "New sub '#{@sub.title}' successfully created!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
  end

  def index
    @subs = Sub.all
    render :index    
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
   @sub = Sub.find_by(id: params[:id])
   
    if @sub.update_attributes(sub_params)
      flash[:notices] = "#{@sub.title} updated!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
