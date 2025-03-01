class GameRoomsController < ApplicationController
  def create
    @game_room = GameRoom.new(create_params)
    if @game_room.save
      render json: @game_room, status: :created
    else
      render json: @game_room.errors, status: :unprocessable_entity
    end
  end

  def show
    @game_room = GameRoom.find_by(room_id: params[:id])
    if @game_room
      render json: { id: @game_room.id }, status: :ok
    else
      render json: { error: "Game room not found" }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:game_room).permit(
      :topic,
      :time_per_answer,
      :lobby_type,
      :accessibility,
      :max_players
    )
  end
end
