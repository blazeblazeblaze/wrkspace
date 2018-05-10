class ContactCirclesForm
  include ActiveModel::Model

  attr_accessor(
    :contact_id,
    :circle_ids
  )

  validates :contact_id, presence: true
  validates :circle_ids, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    Contact.find(contact_id).circle_ids = circle_ids
  end
end
