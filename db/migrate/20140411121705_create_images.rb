class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :picture
      t.string :imageable_type
      t.integer :imageable_id, index: true

      t.timestamps
    end
  end
end
