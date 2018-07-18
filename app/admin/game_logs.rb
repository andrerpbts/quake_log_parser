# frozen_string_literal: true

ActiveAdmin.register GameLog do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :total_kills

    column :players do |game_log|
      game_log.players.to_sentence
    end

    column :created_at

    actions
  end

  filter :created_at

  show do
    attributes_table do
      row :id
      row :total_kills

      row :players do |game_log|
        game_log.players.to_sentence
      end

      row :kills do |game_log|
        pre JSON.pretty_generate(game_log.kills)
      end

      row :created_at
    end
  end
end
