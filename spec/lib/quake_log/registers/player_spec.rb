require 'rails_helper'

RSpec.describe QuakeLog::Registers::Player do
  describe '.call' do
    context 'when player is not registered yet' do
      let(:game) { QuakeLog::Entities::Game.new }
      let(:line) { '1:47 ClientUserinfoChanged: 3 n\Isgalamido\t\0\model\uriel/zael' }

      it 'adds a new player into the game' do
        described_class.call(game, line)

        expect(game.players.map(&:name)).to eq(['Isgalamido'])
      end
    end

    context 'when player is already registered' do
      let(:player) { QuakeLog::Entities::Player.new(name: 'Isgalamido') }
      let(:game) { QuakeLog::Entities::Game.new(players: [player]) }
      let(:line) { '1:47 ClientUserinfoChanged: 3 n\Isgalamido\t\0\model\uriel/zael' }

      it 'adds a new player into the game' do
        described_class.call(game, line)

        expect(game.players.map(&:name)).to eq(['Isgalamido'])
      end
    end
  end
end
