require 'rails_helper'
# describing subject of the spec
RSpec.describe WelcomeController, type: :controller do
    describe "GET index" do
        it "renders the index template" do
            # calling index method of welcome controller
            get :index
            # expect controllers response to render index template
            expect(response).to render_template("index")
        end
    end
    
    describe "GET about" do
        it "renders the about template" do
            get :about
            expect(response).to render_template("about")
        end
    end
end
