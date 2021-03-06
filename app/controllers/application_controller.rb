class ApplicationController < ActionController::Base
  include PathUtils

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :set_locale

  def set_locale
    I18n.locale = I18n.default_locale
    flash[:warn] = nil

    locale = params[:locale]

    if locale
      if not LOCALES.include? locale.to_sym
        flash[:warn] = I18n.translate('locale_not_supported', unsupported_locale: locale)
      else
        I18n.locale = locale
      end
    end
  end

  def self.default_url_options(options={})
    options[:locale] = I18n.locale
    options
  end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    admin_root_path
  end

  private

  def layout_by_resource
    if devise_controller? or admin_page?
      if !user_signed_in?
        'sign_in'
      else
        'admin'
      end
    else
      'application'
    end
  end
end
