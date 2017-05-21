class CreateSnippets < ActiveRecord::Migration[5.1]
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :snippets, [:user_id, :created_at]
  end
end
