class GameRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_room_#{params[:room_code]}"
    send_current_state
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("game_room_#{params[:room_code]}", data)
  end

  private

  def send_current_state
    game_room = GameRoom.find_by(room_code: params[:room_code])
    if game_room
      ActionCable.server.broadcast("game_room_#{params[:room_code]}", {
        messages: game_room.messages,
        letters_pressed: game_room.letters_pressed,
        users: game_room.users,
        time_left: game_room.time_left
      })
    end
  end
end
