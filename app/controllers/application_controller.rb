class ApplicationController < ActionController::Base
  include AccountHelper
  protect_from_forgery with: :exception

  private

  end
end
