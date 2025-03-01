class Message < ApplicationRecord
  belongs_to :session_user
  belongs_to :game_room
end
