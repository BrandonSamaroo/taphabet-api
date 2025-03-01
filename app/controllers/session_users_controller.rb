class SessionUsersController < ApplicationController
  def create
    session_user = SessionUser.new(create_params)

    if session_user.save
      render json: session_user, status: :created
    else
      render json: session_user.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:session_user).permit(:game_room_id)
  end
end
