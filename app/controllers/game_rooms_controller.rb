class GameRoomsController < ApplicationController
  def show
    @game_room = GameRoom.find(params[:id])
    render json: @game_room
  end

  def create
    @game_room = GameRoom.new(create_params)
    if @game_room.save
      render json: @game_room, status: :created
    else
      render json: @game_room.errors, status: :unprocessable_entity
    end
  end

  def update
    @game_room = GameRoom.find(params[:id])
    if @game_room.update(update_params)
      render json: @game_room
    else
      render json: @game_room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @game_room = GameRoom.find(params[:id])
    @game_room.destroy
    head :no_content
  end

  private

  def create_params
    params.require(:game_room).permit(
      :room_code,
      :host_name,
    )
  end

  def update_params
    params.require(:game_room).permit(
      :host_name,
    )
  end
end
