module AccountHelper
  def current_account
    return unless current_user
    current_user.account
  end
end
