class CreateGameRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :game_rooms do |t|
      t.string :room_code, null: false, unique: true
      t.string :host_name, null: false
      t.timestamps
    end
  end
end
