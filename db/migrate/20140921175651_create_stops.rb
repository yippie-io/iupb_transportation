class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.datetime :scheduled_time
      t.string :line_name
      t.string :line_direction
      t.string :line_identifier
      t.string :line_type
      t.string :key
      t.references :station, index: true

      t.timestamps
    end
    add_index :stops, :scheduled_time
    add_index :stops, :line_name
    add_index :stops, :line_direction
  end
end
