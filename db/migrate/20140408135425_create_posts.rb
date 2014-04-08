class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.references :user, index: true
      t.integer :author_id, index: true

      t.timestamps
    end
  end
end
