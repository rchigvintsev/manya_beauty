class RenamePhotosFileNameColumn < ActiveRecord::Migration
  def change
    rename_column :photos, :file_name, :photo_file
  end
end
