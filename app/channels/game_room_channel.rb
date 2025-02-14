class GameRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_room_#{params[:room_code]}"
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("game_room_#{params[:room_code]}", data)
  end
end
