class Person < ApplicationRecord
  belongs_to :organization, required: false
  has_one :contact, as: :contactable
  has_many :cases, through: :contact

  validates :first_name, :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end
end
