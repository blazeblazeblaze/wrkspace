class ApplicationController < ActionController::Base
  include AccountHelper
  layout :layout_by_resource
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def layout_by_resource
    return 'devise' if devise_controller?
    'application'
  end
end
