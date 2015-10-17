class AddEditedByAdminToComments < ActiveRecord::Migration
  def change
    add_column :comments, :edited_by_admin, :boolean
  end
end
