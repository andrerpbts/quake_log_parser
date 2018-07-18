# frozen_string_literal: true

class ImportLogService
  include Service

  def initialize(filename)
    @filename = filename
  end

  def call
    games.each do |game|
      players = game.players.map { |player| [player.name, player.kills] }.to_h
      next if players.blank?

      GameLog.create!(
        total_kills: game.total_kills,
        players: players.keys,
        kills: players
      )
    end
  end

  private

  def games
    @games ||= QuakeLog::Parser.call(filename)
  end

  attr_reader :filename
end
