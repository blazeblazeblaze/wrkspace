module Admin
  class BaseController < ApplicationController
    before_action :authorize_admin!

    private

    def authorize_admin!
      return if current_user.admin?
      redirect_to root_path
    end
  end
end
