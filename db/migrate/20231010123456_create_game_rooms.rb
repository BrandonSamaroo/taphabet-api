class CreateGameRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :game_rooms do |t|
      t.string :room_id, null: false, unique: true
      t.string :topic, null: false
      t.integer :time_per_answer, null: false
      t.string :lobby_type, null: false
      t.string :accessibility, null: false
      t.text :letters_pressed, array: true, default: []
      t.integer :rounds_played, default: 0
      t.integer :player_turn, default: 0
      t.boolean :is_active, default: false
      t.timestamps
    end
  end
end
