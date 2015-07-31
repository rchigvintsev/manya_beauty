module CurrentController extend ActiveSupport::Concern
  private

    def dashboard_controller?
      is_a?(Admin::DashboardController)
    end
end
