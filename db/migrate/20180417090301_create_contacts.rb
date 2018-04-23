class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :contactable, polymorphic: true, index: { unique: true }, null: false
      t.belongs_to :account, index: true, null: false
      t.timestamps
    end
  end
end
