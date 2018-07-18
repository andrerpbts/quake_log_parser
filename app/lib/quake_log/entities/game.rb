# frozen_string_literal: true

module QuakeLog
  module Entities
    class Game
      include Virtus.model

      attribute :total_kills, Integer, default: 0
      attribute :players, Array[Player], default: []
      attribute :kills, Array[Kill], default: []

      def find_or_register_player(name)
        players.find { |player| player.name == name } || register_player(name)
      end

      private

      def register_player(name)
        return if name.blank?

        player = Entities::Player.new(name: name)
        players << player

        player
      end
    end
  end
end
