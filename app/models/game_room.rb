class GameRoom < ApplicationRecord
  before_save :generate_room_code

  validates :host_name, presence: true

  private

  def generate_room_code
    self.room_code = loop do
      random_code = SecureRandom.random_number(10**8).to_s.rjust(8, '0')
      break random_code unless GameRoom.exists?(room_code: random_code)
    end
  end
end
