require 'rails_helper'

RSpec.describe Vote, type: :model do
    let(:topic) { create(:topic) }
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:vote) { create(:vote, post: post, user: user) }
    
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
    # test that value is present when post is created
    it { is_expected.to validate_presence_of(:value) }
    # validate that value is either -1 or 1
    it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }
    
    describe "update post callback" do
        it "triggers update post on save" do
            expect(vote).to receive(:update_post).at_least(:once)
            vote.save!
        end
        it "#update_post should call update rank on post" do
            expect(post).to receive(:update_rank).at_least(:once)
            vote.save!
        end
    end
end
