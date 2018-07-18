require 'rails_helper'

RSpec.describe QuakeLog::Entities::Player do
  describe 'attributes' do
    it 'assigns the attributes correctly using defaults' do
      player = described_class.new

      expect(player.name).to be_nil
      expect(player.kills).to eq(0)
    end

    it 'assigns the given attributes correctly' do
      player = described_class.new(name: 'Isgalamido', kills: 10)

      expect(player.name).to eq('Isgalamido')
      expect(player.kills).to eq(10)
    end
  end
end
