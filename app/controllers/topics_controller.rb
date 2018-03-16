class TopicsController < ApplicationController
    # redirect guests when they try and access anything other than index and show
    before_action :require_sign_in, except: [:index, :show]
    # check the role of signed in users, if not a user we redirect to index view
    before_action :authorize_user, except: [:index, :show]
    def index
        @topics = Topic.all
    end
    
    def show
        @topic = Topic.find(params[:id])
    end
    
    def new 
        @topic = Topic.new
    end
    
    def create
        @topic = Topic.new(topic_params)
        
        if @topic.save 
            redirect_to @topic, notice: "Topic was saved successfully."
        else 
            flash.now[:alert] = "Error creating topic. Please try again."
            render :new
        end
    end
    
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
        @topic.assign_attributes(topic_params)
        
        if @topic.save 
            redirect_to @topic, notice: "Topic was saved successfully."
        else
            flash.now[:alert] = "Error creating topic. Please try again."
            render :edit
        end
    end
    
    def destroy 
        @topic = Topic.find(params[:id])
        
        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
            # same as redirect_to topics_path because of resourceful routing
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the topic."
            render :show
        end
    end
    
    private
    def topic_params
        params.require(:topic).permit(:name, :description, :public)
    end
    
    def authorize_user
        unless current_user.admin?
        flash[:alert] = "You must be an admin to do that"
        redirect_to topics_path
        end
    end
end
