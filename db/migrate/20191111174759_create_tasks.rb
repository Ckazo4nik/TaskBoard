class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :priority, default: 0
      t.date :to_do_until
      t.integer :status, default: 0
      t.belongs_to :project
      t.string :name

      t.timestamps
    end
  end
end
