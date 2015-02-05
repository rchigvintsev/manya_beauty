module StaticPagesHelper
  def home_page?
    static_pages_action?('home')
  end

  def gallery_page?
    static_pages_action?('gallery')
  end

  private

  def static_pages_action?(action_name)
    params[:controller] == 'static_pages' && params[:action] == action_name
  end
end
