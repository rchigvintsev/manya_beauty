class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :photo_id
      t.string :author
      t.string :text
      t.boolean :published
      t.timestamp :published_at

      t.timestamps
    end

    add_index :comments, [:photo_id, :created_at]
  end
end
