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
 #  describe "GET show" do
 #    it "returns http success" do
 #      get :show
 #      expect(response).to have_http_status(:success)
 #    end
 #  end

 # describe "GET new" do
 #   it "returns http success" do
 #     get :new
 #     expect(response).to have_http_status(:success)
 #   end
 # end

 #  describe "GET edit" do
 #    it "returns http success" do
 #      get :edit
 #      expect(response).to have_http_status(:success)
 #    end
 #  end

end