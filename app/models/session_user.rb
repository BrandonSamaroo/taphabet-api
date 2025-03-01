class SessionUser < ApplicationRecord
  belongs_to :game_room
  has_many :messages

  before_create :generate_name
  after_create :broadcast_create

  private

  def generate_name
    self.name = Faker::Internet.username.camelize
  end

  def broadcast_create
    if game_room.session_users.count > 1
      ActionCable.server.broadcast("game_room_#{game_room.room_id}", {
        session_users: game_room.session_users
      })
    end
  end
end
