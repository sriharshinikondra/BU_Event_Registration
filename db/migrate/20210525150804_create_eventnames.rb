class CreateEventnames < ActiveRecord::Migration
  def change
    create_table :eventnames do |t|
      t.string :eventnamecode
      t.string :title
      t.string :description
     
      t.timestamps null: false
    end
  end
end
