module StaticPagesHelper
  def home_page?
    static_pages_action?('home')
  end

  def gallery_page?
    static_pages_action?('gallery') ||
        (params[:controller] == 'gallery/photo_albums' && params[:action] == 'show')
  end

  def about_page?
    static_pages_action?('about')
  end

  private

    def static_pages_action?(action_name)
      params[:controller] == 'static_pages' && params[:action] == action_name
    end
end
