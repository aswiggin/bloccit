class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_foreign_key :comments, :posts
  end
end
