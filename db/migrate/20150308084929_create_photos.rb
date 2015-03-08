class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photo_album_id
      t.string :title
      t.string :description
      t.string :file_name

      t.timestamps
    end

    add_index :photos, [:photo_album_id, :created_at]
  end
end
