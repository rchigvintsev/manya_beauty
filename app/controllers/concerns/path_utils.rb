module PathUtils extend ActiveSupport::Concern
  private

    def admin_page?
      path_inf = request.env['PATH_INFO']
      path_inf.start_with? '/admin'
    end
end
