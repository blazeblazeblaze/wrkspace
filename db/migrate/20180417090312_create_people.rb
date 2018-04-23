class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :title
      t.string :job_title

      t.belongs_to :organization, index: true
      t.timestamps
    end
  end
end
