class CreateGameRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :game_rooms do |t|
      t.string :room_code, null: false, unique: true
      t.string :host_name, null: false
      t.text :messages, array: true, default: []
      t.text :letters_pressed, array: true, default: []
      t.text :users, array: true, default: []
      t.integer :time_left, default: 15
      t.boolean :is_game_active, default: false
      t.string :category, default: "N/A"
      t.string :room_type, default: "Manual"

      t.timestamps
    end
  end
end
