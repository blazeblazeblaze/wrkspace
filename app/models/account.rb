class Account < ApplicationRecord
  has_many :circles
  has_many :users
  has_many :contacts
  has_many :organizations, through: :contacts, source: 'contactable', source_type: 'Organization'
  has_many :people, through: :contacts, source: 'contactable', source_type: 'Person'

  validates :name, presence: true, uniqueness: true
end
