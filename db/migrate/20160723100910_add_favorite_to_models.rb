class AddFavoriteToModels < ActiveRecord::Migration
  def change
    add_column :models, :favorite, :boolean
  end
end
