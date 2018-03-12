class AddTopicToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :topic_id, :integer
    # created an index on topic_id, which improves the speed of operations
    add_index :posts, :topic_id
  end
end
