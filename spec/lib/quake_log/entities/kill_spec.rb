require 'rails_helper'

RSpec.describe QuakeLog::Entities::Kill do
  describe 'attributes' do
    it 'assigns the attributes correctly using defaults' do
      kill = described_class.new

      expect(kill.killer).to be_nil
      expect(kill.killed).to be_nil
      expect(kill.weapon).to be_nil
    end

    it 'assigns the given attributes correctly' do
      killer = QuakeLog::Entities::Player.new(name: 'Isgalamido')
      killed = QuakeLog::Entities::Player.new(name: 'Zeh')
      kill = described_class.new(killer: killer, killed: killed, weapon: 'MOD_HURT')

      expect(kill.killer).to eq(killer)
      expect(kill.killed).to eq(killed)
      expect(kill.weapon).to eq('MOD_HURT')
    end
  end
end
