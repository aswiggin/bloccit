class PostsController < ApplicationController
  def index
    # Created an instance variable and assigned it to a collection of Post objects
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
