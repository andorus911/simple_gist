class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :snippet_id
      t.integer :user_id

      t.timestamps
    end
    add_index :comments, [:snippet_id, :created_at]
  end
end
