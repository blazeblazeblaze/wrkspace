class Case < ApplicationRecord
  belongs_to :contact
  belongs_to :assigned_user, class_name: 'User'

  validates :name, presence: true
  validates :contact, presence: true
end
