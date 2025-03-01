class GameRoom < ApplicationRecord
  has_many :session_users, dependent: :destroy
  has_many :messages, dependent: :destroy

  before_create :generate_room_code
  before_create :set_defaults

  validates :room_id, uniqueness: true

   # enums not working for strings validate this later for lobby_type and accessibility

  private

  def generate_room_code
    self.room_id = SecureRandom.hex(10)
  end

  def set_defaults
    self.topic = self.topic.upcase_first
  end
end
