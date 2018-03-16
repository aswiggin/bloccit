class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  # check the role of a signed in user, if not authorized they are redirected to the show view
  before_action :authorize_user, except: [:show, :new, :create]
  
  def show
    # find the post that corresponds to the id in the params that was passed to show and assign it to post
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    # assign a topic to a post
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    
    if @post.save
      # change redirect to use neseted path
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
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
    @post.assign_attributes(post_params)

    if @post.save 
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else 
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      # redirect to topic show view when post is deleted. 
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
  
  private 
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
    flash[:alert] = "You must be an admin to do that."
    redirect_to [post.topic, post]
    end
  end
end


