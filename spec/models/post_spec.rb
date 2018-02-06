require 'rails_helper'

RSpec.describe Post, type: :model do
    # creating a new instance of the post class and computes and stoes the returned value when called in the it block
    let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
    describe attributes do
        # tests whether post has attributes
        it "has title and body attributes" do
            expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
        end
    end
end
