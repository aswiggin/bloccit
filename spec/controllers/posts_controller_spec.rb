require 'rails_helper'
# added so we can use create_session(user) method later
include SessionsHelper
# Tells RSPEC to treat the test as a controller test
RSpec.describe PostsController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # Create a post and assign it to my_post using let
  # create a parent topic
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  # make sure my_post belongs to my_topic
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
  
  context "guest user" do
    describe "GET show" do
      it "returns HTTP success" do
        get :show, params: { topic_id: my_topic.id, id: my_post.id }
        expect(response).to have_http_status(:success)
      end
      
      it "renders the #show view" do
         get :show, params: { topic_id: my_topic.id, id: my_post.id }
         expect(response).to render_template :show
       end
 
       it "assigns my_post to @post" do
         get :show, params: { topic_id: my_topic.id, id: my_post.id }
         expect(assigns(:post)).to eq(my_post)
       end
     end
 
    describe "GET new" do
       it "returns http redirect" do
         get :new, params: { topic_id: my_topic.id }
         expect(response).to redirect_to(new_session_path)
       end
     end
 
     describe "POST create" do
       it "returns http redirect" do
         post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
         expect(response).to redirect_to(new_session_path)
       end
     end
 
     describe "GET edit" do
       it "returns http redirect" do
         get :edit, params: { topic_id: my_topic.id, id: my_post.id }
         expect(response).to redirect_to(new_session_path)
       end
     end
 
     describe "PUT update" do
       it "returns http redirect" do
         new_title = RandomData.random_sentence
         new_body = RandomData.random_paragraph
 
         put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }
         expect(response).to redirect_to(new_session_path)
       end
     end
 
     describe "DELETE destroy" do
       it "returns http redirect" do
         delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
         expect(response).to have_http_status(:redirect)
       end
     end
   end
   
   # wrap existing specs in a context so they become our signed-in user specs
   context "signed-in user" do
     before do
       create_session(my_user)
     end

# Performs a get on the index view and expects the response to be successful
  describe "GET show" do
     it "returns http success" do
         
        get :show, params: { topic_id: my_topic.id, id: my_post.id }
        expect(response).to have_http_status(:success)
    end
    it "renders the show# view" do
        
        get :show, params: { topic_id: my_topic.id, id: my_post.id }
        expect(response).to render_template :show
    end
    it "assings my_post to @post" do
        get :show, params: { topic_id: my_topic.id, id: my_post.id }
        # we expect the post to equal my post because we call show with the id of my_post 
        expect(assigns(:post)).to eq(my_post)
    end
end

  describe "GET new" do
      it "returns http success" do
          get :new, params: { topic_id: my_topic.id }
          expect(response).to have_http_status(:success)
      end
      # we expect PostController#new to render the posts new view
      it "renders the #new view" do
          get :new, params: { topic_id: my_topic.id }
          expect(response).to render_template :new
      end
      # we expect the @post instance variable to be initiated by PostController#new and we use assigns to get access @post and assign it to :post
      it "instantiates @post" do
          get :new, params: { topic_id: my_topic.id }
          expect(assigns(:post)).not_to be_nil
      end
  end
    
  describe "POST create" do
      # we expect that after PostController#create is called with the params that the database will increase by one
      it "increases the number of Post by 1" do
          expect{ post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
      end
      # when create is POSTed to we expect the new post to be assigned to @post
      it "assigns the new post to @post" do 
          post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
          expect(assigns(:post)).to eq Post.last
      end
      # we expect to be redirected to the newly created post
      it "redirects to the new post" do
          post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
          expect(response).to redirect_to [my_topic, Post.last]
      end
  end
  
  describe "GET edit" do
    it "returns htttp success" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to render_template :edit 
    end
    # test that edit assigns the correct post to be updated to @post
    it "assigns post to be updated to @post" do
      get :edit, params: { topic_id: my_topic.id, id: my_post.id }
      post_instance = assigns(:post)
      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end
  
  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body} }
      # test that the updated posts id is unchanged
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
    
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body} }
      # expect to be redirected to the posts show view after the update
      expect(response).to redirect_to [my_topic, my_post]
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      # search the database for a post with id my_post.id 
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end
    
    it "redirects to topic show" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
      expect(response).to redirect_to my_topic
    end
  end
 end
end