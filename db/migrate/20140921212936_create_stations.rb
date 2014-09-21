class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :query_name
      t.float :lat
      t.float :long
      t.text :comment

      t.timestamps
    end
    add_index :stations, :name
  end
end
