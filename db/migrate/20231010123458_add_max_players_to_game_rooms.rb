class AddMaxPlayersToGameRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :game_rooms, :max_players, :integer, default: 4
  end
end
