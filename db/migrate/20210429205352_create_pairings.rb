class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.string :eventorganizer
      t.string :student
      t.string :eventname
      t.datetime :date

      t.timestamps null: false
    end
  end
end
