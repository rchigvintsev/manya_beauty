module DeviseHelper
  def devise_error_messages!
    flash_errors = []

    if !flash.empty? and flash[:alert]
      flash_errors.push(flash[:alert])
    end

    return '' if resource.errors.empty? and flash_errors.empty?

    errors = resource.errors.empty? ? flash_errors : resource.errors.full_messages
    if errors.length == 1
      messages = errors.first
    else
      messages = "<ul>#{errors.map { |e| content_tag(:li, e) }.join}</ul>"
    end
    html = <<-HTML
      <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        #{messages}
      </div>
    HTML
    html.html_safe
  end
end
