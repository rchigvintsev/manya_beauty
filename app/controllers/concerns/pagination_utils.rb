module PaginationUtils
  extend ActiveSupport::Concern
  private

  def current_page
    page = params[:page]
    (page.nil? or page.empty?) ? nil : page
  end

  def last_page(model)
    unless model
      return nil
    end
    model_class = model.to_s.camelize.constantize
    last_page = model_class.paginate(page: 1).total_pages
    last_page == 1 ? nil : last_page
  end
end
