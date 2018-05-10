class CreateCircleContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :circle_contacts do |t|
      t.belongs_to :circle, null: false
      t.belongs_to :contact, null: false

      t.timestamps
    end
  end
end
