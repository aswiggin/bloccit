class PostsController < ApplicationController
  def index
    # Created an instance variable and assigned it to a collection of Post objects
    @posts = Post.all
    @posts.each_with_index do |post, index|
      if index % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
