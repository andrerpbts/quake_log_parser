require 'rails_helper'

RSpec.describe Admin::GameLogsController, type: :controller do
  let(:admin_user) { create :admin_user }
  let(:game_log) { create :game_log }

  before { sign_in admin_user }

  describe 'GET index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'assigns the game_logs' do
      get :index

      expect(assigns(:game_logs)).to include(game_log)
    end
  end

  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: game_log.id }

      expect(response).to have_http_status(200)
    end

    it 'assigns the game_log' do
      get :show, params: { id: game_log.id }

      expect(assigns(:game_log)).to eq(game_log)
    end
  end

  describe 'POST destroy' do
    it 'redirects to index' do
      post :destroy, params: { id: game_log.id }

      expect(response).to redirect_to(admin_game_logs_path)
    end

    it 'deletes the game_log' do
      post :destroy, params: { id: game_log.id }

      expect { game_log.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
