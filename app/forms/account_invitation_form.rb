class AccountInvitationForm
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :email
  )

  validates :user_id, presence: true
  validates :email, presence: true

  attr_reader :user

  def save
    return false unless valid?

    find_account_owner
    build_user

    if @invited.persisted?
      true
    else
      merge_errors
      false
    end
  end

  private

  def find_account_owner
    @owner = User.find(user_id)
  end

  def build_user
    @invited = User.invite!(
      {
        email: email,
        account_id: @owner.account_id
      },
      @owner
    )
  end

  def merge_errors
    errors.merge!(@invited.errors)
  end
end
