class Circle < ApplicationRecord
  belongs_to :account
  has_many :circle_contacts
  has_many :contacts, through: :circle_contacts

  validates :title, presence: true
end
