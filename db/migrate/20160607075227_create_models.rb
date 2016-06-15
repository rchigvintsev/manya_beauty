class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.integer :photo_album_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
