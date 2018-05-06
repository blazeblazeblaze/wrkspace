class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.string :title, default: '', null: false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
