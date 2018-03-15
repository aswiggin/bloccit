class Post < ApplicationRecord
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    # order post by their created_at date in decending order
    default_scope { order('created_at DESC') }
    
   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
   validates :user, presence: true
end
