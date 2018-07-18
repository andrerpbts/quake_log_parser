# frozen_string_literal: true

module QuakeLog
  class Parser
    include Service

    def initialize(filename)
      @filename = filename
      @games = []
    end

    def call
      return [] unless File.exist?(filename)

      File.open(filename, 'r') do |f|
        f.each_line { |line| parse(line) }
      end

      games
    end

    private

    def parse(line)
      case line
      when /InitGame:/
        games << Entities::Game.new
      when /ClientUserinfoChanged:/
        Registers::Player.call(current_game, line)
      when /Kill:/
        Registers::Kill.call(current_game, line)
      end
    end

    def current_game
      games.last
    end

    attr_reader :filename, :games
  end
end
