class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.belongs_to :direction, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :rating
      t.text :review
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
