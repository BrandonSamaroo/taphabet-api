class CreateSessionUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :session_users do |t|
      t.string :name, null: false
      t.integer :games_won, default: 0
      t.text :letters_used, array: true, default: []
      t.boolean :is_turn, default: false

      t.timestamps
    end
  end
end
