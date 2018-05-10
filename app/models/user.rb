class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :registerable, :invitable, validate_on_invite: true

  belongs_to :account
  has_many :tasks

  def suspend!
    return true if suspended_at
    update(suspended_at: Time.current)
  end

  def active_for_authentication?
    super && !suspended_at
  end

  def inactive_message
    !suspended_at ? super : :suspended_account
  end
end
