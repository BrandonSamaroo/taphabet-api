class AddSessionUsersToGameRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :session_users, :game_room, foreign_key: true
  end
end
