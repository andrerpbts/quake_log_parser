# frozen_string_literal: true

module QuakeLog
  module Registers
    class Player < Base
      def call
        player_name = line_values.first

        game.find_or_register_player(player_name)
      end

      private

      def expression
        /ClientUserinfoChanged: \d n\\(.*)\\t\\0/
      end
    end
  end
end
