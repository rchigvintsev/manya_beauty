module CategoriesHelper
  def current_category?(category)
    category.id.to_s == params[:category_id]
  end
end
