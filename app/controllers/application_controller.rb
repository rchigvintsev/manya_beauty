class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    options[:locale] = I18n.locale
    options
  end

  def after_sign_in_path_for(resource)
    admin_dashboard_index_path
  end

  def after_sign_out_path_for(resource_or_scope)

  end

  private

    def layout_by_resource
      if devise_controller?
        if user_signed_in?
          'dashboard'
        else
          'signin'
        end
      else
        'application'
      end
    end
end
