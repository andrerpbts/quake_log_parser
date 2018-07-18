# frozen_string_literal: true

ActiveAdmin.register GameLog do
  actions :index, :show, :destroy

  action_item :import_log, only: :index do
    link_to 'Import Log', import_log_admin_game_logs_path
  end

  collection_action :import_log, method: %i[get post] do
    if request.post?
      filename = "/tmp/#{Time.current.to_i}.log"

      File.open(filename, 'w') { |file| file.write(params[:log_file].read) }
      ImportLogService.call(filename)

      redirect_to collection_path, notice: 'Log imported successfully!'
    end
  end

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
