class GameRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_room_#{params[:room_id]}"
    send_current_state
  end

  def unsubscribed
    
  end

  def receive(data)
    game_room = GameRoom.find_by(room_id: params[:room_id])

    response_data = if data['message_body']
      message = Message.create!(
        body: data['message_body'],
        game_room_id: game_room.id,
        session_user_id: data['session_user_id']
      )

      { message: "#{message.session_user.name}: #{message.body}" }
    elsif data['letter_pressed']
      user = SessionUser.find(data['session_user_id'])

      user.letters_used << data['letter_pressed']
      user.save

      game_room.letters_pressed << data['letter_pressed']
      game_room.save
      
      player_turn = game_room.player_turn == game_room.session_users.count - 1 ? 0 : game_room.player_turn + 1

      game_room.update(player_turn: player_turn)

      { letter_pressed: data['letter_pressed'], player_turn: game_room.player_turn }
    elsif data['is_active'] != nil
      game_room.update(is_active: data['is_active'])
      if (!data['is_active'])
        game_room.update(rounds_played: game_room.rounds_played + 1)
        user.update(games_won: user.games_won + 1)
      end

      { is_active: game_room.is_active, rounds_played: game_room.rounds_played }
    else 
      return
    end

    ActionCable.server.broadcast("game_room_#{params[:room_id]}", response_data)
  end

  private

  def send_current_state
    session_user = SessionUser.find(params[:session_user_id])
    game_room = GameRoom.find_by(room_id: params[:room_id])

    if !game_room || !session_user || (game_room.max_players == game_room.session_users.count)
      transmit({
        error: "Unable to join session"
      })
      return
    end

    if !game_room.session_users.map(&:id).include?(session_user.id)
      game_room.session_users << session_user
      game_room.save!
    end

    transmit({
      game_room_id: game_room.id,
      topic: game_room.topic,
      time_per_answer: game_room.time_per_answer,
      lobby_type: game_room.lobby_type,
      accessibility: game_room.accessibility,
      letters_pressed: game_room.letters_pressed,
      rounds_played: game_room.rounds_played,
      player_turn: game_room.player_turn,
      is_active: game_room.is_active,
      max_players: game_room.max_players,
      session_users: game_room.session_users,
    })
  end
end
