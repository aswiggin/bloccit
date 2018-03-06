class PostsController < ApplicationController
  def index
    # Created an instance variable and assigned it to a collection of Post objects
    @posts = Post.all
  end

  def show
    # find the post that corresponds to the id in the params that was passed to show and assign it to post
    @post = Post.find(params[:id])
  end

  def new
    # create an instance variable and assign it to an empty post
    @post = Post.new
  end
  
  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:title]
    
    if @post.save
      
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    
    if @post.save 
      flash[:notice] = "Post was updated."
      redirect_to @post
    else 
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
end
