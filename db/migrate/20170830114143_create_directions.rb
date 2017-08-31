class CreateDirections < ActiveRecord::Migration[5.0]
  def change
   create_table :directions do |t|
      t.integer :distance, null: false
      t.integer :duration, null: false
      t.string :end_address, null: false
      t.string :start_address, null: false
      t.json :end_location
      t.json :start_location
      t.datetime :start_date, null: false
      t.integer :cost, null: false
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
