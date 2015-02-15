class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.integer :category_id
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :photo_albums, [:category_id, :created_at]
  end
end
