class Organization < ApplicationRecord
  has_many :people
  has_one :contact, as: :contactable
  has_many :cases, through: :contact

  validates :name, presence: true
end
