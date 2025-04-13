class ApplicationComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers
  include ApplicationHelper
  include ProductsHelper
  include Turbo::FramesHelper
end
