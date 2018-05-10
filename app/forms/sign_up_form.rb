class SignUpForm
  include ActiveModel::Model

  attr_accessor(
    :account_name,
    :email,
    :password,
    :password_confirmation
  )

  validates :account_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  attr_reader :admin, :account

  def save
    return false unless valid?

    build_new_account
    build_admin_user

    if @account.valid? && @admin.valid?
      persist!
      true
    else
      merge_errors!
      false
    end
  end

  private

  def build_admin_user
    @admin = @account.users.build(
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      admin: true
    )
  end

  def build_new_account
    @account = Account.new(
      name: account_name
    )
  end

  def merge_errors!
    errors.merge!(@account.errors)
    errors.merge!(@admin.errors)
  end

  def persist!
    @account.save!
  end
end
