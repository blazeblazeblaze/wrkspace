class CreateCircles < ActiveRecord::Migration[5.2]
  def change
    create_table :circles do |t|
      t.string :title, null: false
      t.belongs_to :account, index: true, null: false
      t.timestamps
    end
  end
end
