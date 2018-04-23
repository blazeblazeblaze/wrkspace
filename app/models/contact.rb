class Contact < ApplicationRecord
  has_many :cases
  belongs_to :account
  belongs_to :contactable, polymorphic: true

  scope :people, -> { where(contactable_type: 'Person') }
  scope :organizations, -> { where(contactable_type: 'Organization') }

  validates_associated :contactable

  def name
    contactable.name
  end
end
