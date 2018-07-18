# frozen_string_literal: true

module V1
  class GameLogsController < ApiController
    def index
      page = params.fetch(:page, 1)
      per_page = params.fetch(:per_page, 15)

      @game_logs = GameLog.all.page(page).per(per_page)

      render json: @game_logs, status: :ok
    end

    def show
      @game_log = GameLog.find(params[:id])

      render json: @game_log, status: :ok
    end
  end
end
