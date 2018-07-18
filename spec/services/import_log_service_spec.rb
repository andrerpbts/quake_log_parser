require 'rails_helper'

RSpec.describe ImportLogService do
  describe '.call' do
    let(:filename) { file_fixture('single.log') }

    it 'creates a new game log' do
      expected = {
        'total_kills' => 49,
        'players' => ['Dono da Bola', 'Isgalamido', 'Zeh', 'Assasinu Credi'],
        'kills' => {
          'Dono da Bola' => 4,
          'Zeh' => 12,
          'Isgalamido' => 8,
          'Assasinu Credi' => 5
        }
      }

      described_class.call(filename)

      expect(GameLog.count).to eq(1)
      expect(GameLog.last.attributes).to include(expected)
    end
  end
end
