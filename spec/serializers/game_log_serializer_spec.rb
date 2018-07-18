require 'rails_helper'

RSpec.describe GameLogSerializer, type: :serializer do
  describe '#to_json' do
    let(:obj) { create(:game_log) }

    it 'correctly serializes' do
      expected = {
        id: obj.id,
        total_kills: obj.total_kills,
        players: obj.players,
        kills: obj.kills
      }.to_json

      expect(serialize(obj)).to eq(expected)
    end
  end
end
