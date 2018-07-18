require 'rails_helper'

RSpec.describe 'Game Logs Request', type: :request do
  describe '#GET /v1/game_logs' do
    let!(:game_logs) { create_list(:game_log, 2) }

    subject(:fetch) do
      get '/v1/game_logs', params: { page: 1, per_page: 2 }
    end

    it 'returns the correct 200 response code' do
      fetch

      expect(response).to have_http_status(200)
    end

    it 'returns the expected response body' do
      fetch

      expect(response.body)
        .to eq(serialize_all(game_logs, GameLogSerializer).to_json)
    end

    it 'returns only per_page records' do
      create_list(:game_log, 2)

      fetch

      expect(JSON.parse(response.body).count).to eq(2)
    end
  end

  describe '#GET /v1/game_logs/:id' do
    let!(:game_log) { create(:game_log) }

    subject(:fetch) do
      get "/v1/game_logs/#{game_log.id}"
    end

    it 'returns the correct 200 response code' do
      fetch

      expect(response).to have_http_status(200)
    end

    it 'returns the expected response body' do
      fetch

      expect(response.body)
        .to eq(serialize(game_log, GameLogSerializer).to_json)
    end
  end
end
