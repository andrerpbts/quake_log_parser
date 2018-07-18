require 'rails_helper'

RSpec.describe QuakeLog::Parser do
  describe '.call' do
    let(:filename) { file_fixture('single.log') }

    let(:players) do
      [
        { 'name' => 'Dono da Bola',   'kills' =>  4 },
        { 'name' => 'Isgalamido',     'kills' =>  8 },
        { 'name' => 'Zeh',            'kills' => 12 },
        { 'name' => 'Assasinu Credi', 'kills' =>  5 }
      ]
    end

    let(:kills) do
      [
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_RAILGUN'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_RAILGUN'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_RAILGUN'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_RAILGUN'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_RAILGUN'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_MACHINEGUN'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_MACHINEGUN'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'killed' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Zeh',            'kills' => 12 },
          'killed' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Assasinu Credi', 'kills' =>  5 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Isgalamido',     'kills' =>  8 },
          'weapon' => 'MOD_ROCKET_SPLASH'
        },
        {
          'killer' => { 'name' => 'Dono da Bola',   'kills' =>  4 },
          'killed' => { 'name' => 'Zeh',            'kills' => 12 },
          'weapon' => 'MOD_ROCKET'
        }
      ]
    end

    subject(:game) { described_class.call(filename).first }

    it { expect(game.total_kills).to eq(49) }
    it { expect(game.players.map(&:as_json)).to match(players) }
    it { expect(game.kills.map(&:as_json)).to match(kills) }
  end
end
