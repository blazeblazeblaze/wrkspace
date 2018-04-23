class CreateCases < ActiveRecord::Migration[5.1]
  def change
    create_table :cases do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :closed_at
      t.belongs_to :assigned_user, index: true
      t.belongs_to :contact, index: true
      t.timestamps
    end
  end
end
