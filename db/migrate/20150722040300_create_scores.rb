class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value
      t.text :description
      t.date :day
      t.string :time_of_day
      t.integer :user_id

      t.timestamps
    end
  end
end
