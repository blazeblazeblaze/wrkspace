class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_account

  private

  def load_account
    @current_account = Account.first
  end
end
