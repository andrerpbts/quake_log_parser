require 'rails_helper'

RSpec.describe QuakeLog::Entities::Game do
  describe 'attributes' do
    it 'assigns the attributes correctly using defaults' do
      game = described_class.new

      expect(game.total_kills).to eq(0)
      expect(game.players).to eq([])
      expect(game.kills).to eq([])
    end

    it 'assigns the given attributes correctly' do
      kills = [QuakeLog::Entities::Kill.new]
      players = [QuakeLog::Entities::Player.new]
      game = described_class.new(total_kills: 1, players: players, kills: kills)

      expect(game.total_kills).to eq(1)
      expect(game.players).to eq(players)
      expect(game.kills).to eq(kills)
    end
  end

  describe '#find_or_register_player' do
    context 'when a player already exists' do
      let(:player) { QuakeLog::Entities::Player.new(name: 'Zeh') }
      let(:game) { described_class.new(players: [player]) }

      it 'does not add a new player' do
        game.find_or_register_player('Zeh')

        expect(game.players.map(&:name)).to eq(['Zeh'])
      end

      it 'returns the existing player' do
        new_player = game.find_or_register_player('Zeh')

        expect(new_player).to eq(player)
      end
    end

    context 'when a player not still exists' do
      let(:game) { described_class.new }

      it 'adds a new player' do
        game.find_or_register_player('Zeh')

        expect(game.players.map(&:name)).to eq(['Zeh'])
      end

      it 'returns the new player' do
        new_player = game.find_or_register_player('Zeh')

        expect(new_player.name).to eq('Zeh')
      end
    end
  end
end
