require 'rails_helper'
# Tells RSPEC to treat the test as a controller test
RSpec.describe PostsController, type: :controller do
  # Create a post and assign it to my_post using let
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_post] to @posts" do 
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end
# Performs a get on the index view and expects the response to be successful
  describe "GET show" do
     it "returns http success" do
         
        get :show, params: { id: my_post.id }
        expect(response).to have_http_status(:success)
    end
    it "renders the show# view" do
        
        get :show, params: { id: my_post.id }
        expect(response).to render_template :show
    end
    it "assings my_post to @post" do
        get :show, params: { id: my_post.id }
        # we expect the post to equal my post because we call show with the id of my_post 
        expect(assigns(:post)).to eq(my_post)
    end
end

  describe "GET new" do
      it "returns http success" do
          get :new
          expect(response).to have_http_status(:success)
      end
      # we expect PostController#new to render the posts new view
      it "renders the #new view" do
          get :new
          expect(response).to render_template :new
      end
      # we expect the @post instance variable to be initiated by PostController#new and we use assigns to get access @post and assign it to :post
      it "instantiates @post" do
          get :new
          expect(assigns(:post)).not_to be_nil
      end
      # we expect that after PostController#create is called with the params that the database will increase by one
      it "increases the number of Post by 1" do
          expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
      end
      # when create is POSTed to we expect the new post to be assigned to @post
      it "assigns the new post to @post" do 
          post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
          expect(assigns(:post)).to eq Post.last
      end
      # we expect to be redirected to the newly created post
      it "redirects to the new post" do
          post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
          expect(response).to redirect_to Post.last
      end
  end



 #  describe "GET edit" do
 #    it "returns http success" do
 #      get :edit
 #      expect(response).to have_http_status(:success)
 #    end
 #  end

end