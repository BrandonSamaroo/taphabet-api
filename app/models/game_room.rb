class GameRoom < ApplicationRecord
  validates :room_code, presence: true, uniqueness: true
  validates :host_name, presence: true
end
