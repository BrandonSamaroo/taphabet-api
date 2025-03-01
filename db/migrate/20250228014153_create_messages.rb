class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :session_user, null: false, foreign_key: true
      t.references :game_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
