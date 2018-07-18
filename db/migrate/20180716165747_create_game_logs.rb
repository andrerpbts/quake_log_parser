class CreateGameLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :game_logs do |t|
      t.integer :total_kills, default: 0
      t.string :players, array: true, default: []
      t.jsonb :kills

      t.timestamps
    end
  end
end
