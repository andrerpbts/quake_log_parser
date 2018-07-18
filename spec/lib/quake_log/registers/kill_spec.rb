require 'rails_helper'

RSpec.describe QuakeLog::Registers::Kill do
  describe '.call' do
    context 'when player was killed by another player' do
      let(:game) { QuakeLog::Entities::Game.new(total_kills: 5) }
      let(:line) { '11:57 Kill: 4 3 7: Zeh killed Isgalamido by MOD_ROCKET_SPLASH' }

      it 'increases the total kills' do
        described_class.call(game, line)

        expect(game.total_kills).to eq(6)
      end

      it 'creates a new kill entry' do
        described_class.call(game, line)

        kill = game.kills.last

        expect(kill.killer.name).to eq('Zeh')
        expect(kill.killed.name).to eq('Isgalamido')
        expect(kill.weapon).to eq('MOD_ROCKET_SPLASH')
      end
    end

    context 'when player was killed by world' do
      context 'and the killed does not have any frags yet' do
        let(:line) { '11:40 Kill: 1022 5 19: <world> killed Assasinu Credi by MOD_FALLING' }
        let(:player) { QuakeLog::Entities::Player.new(name: 'Assasinu Credi', kills: 0) }
        let(:game) { QuakeLog::Entities::Game.new(players: [player]) }

        it 'increases the total kills' do
          described_class.call(game, line)

          expect(game.total_kills).to eq(1)
        end

        it 'does not decreases the killed kills bellow 0' do
          described_class.call(game, line)

          expect(player.kills).to be_zero
        end

        it 'does not create a new kill' do
          described_class.call(game, line)

          expect(game.kills).to be_empty
        end
      end

      context 'and the killed have some frags' do
        let(:line) { '11:40 Kill: 1022 5 19: <world> killed Assasinu Credi by MOD_FALLING' }
        let(:player) { QuakeLog::Entities::Player.new(name: 'Assasinu Credi', kills: 7) }
        let(:game) { QuakeLog::Entities::Game.new(players: [player]) }

        it 'increases the total kills' do
          described_class.call(game, line)

          expect(game.total_kills).to eq(1)
        end

        it 'decreases the killed kills' do
          described_class.call(game, line)

          expect(player.kills).to eq(6)
        end

        it 'does not create a new kill' do
          described_class.call(game, line)

          expect(game.kills).to be_empty
        end
      end
    end

    context 'when player was killed by himself' do
      let(:line) { ' 11:30 Kill: 5 5 7: Assasinu Credi killed Assasinu Credi by MOD_ROCKET_SPLASH' }
      let(:player) { QuakeLog::Entities::Player.new(name: 'Assasinu Credi', kills: 2) }
      let(:game) { QuakeLog::Entities::Game.new(total_kills: 3, players: [player]) }

      it 'increases the total kills' do
        described_class.call(game, line)

        expect(game.total_kills).to eq(4)
      end

      it 'does not increases or decreases the player kills' do
        described_class.call(game, line)

        expect(player.kills).to eq(2)
      end

      it 'does not create a new kill' do
        described_class.call(game, line)

        expect(game.kills).to be_empty
      end
    end
  end
end
