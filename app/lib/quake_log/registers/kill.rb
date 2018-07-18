# frozen_string_literal: true

module QuakeLog
  module Registers
    class Kill < Base
      def initialize(*args)
        super(*args)
        @killer_name, @killed_name, @weapon = line_values
      end

      def call
        increase_total_kills
        register_kill
      end

      private

      def increase_total_kills
        game.total_kills += 1
      end

      def register_kill
        return if killer == killed

        if killer
          killer.kills += 1
          game.kills << Entities::Kill.new(killer: killer, killed: killed, weapon: weapon)
        elsif killed.kills.positive?
          killed.kills -= 1
        end
      end

      def killer
        return if killer_name == '<world>'

        @killer ||= game.find_or_register_player(killer_name)
      end

      def killed
        @killed ||= game.find_or_register_player(killed_name)
      end

      def expression
        /Kill: .*: (.*) killed (.*) by (.*)/
      end

      attr_reader :killer_name, :killed_name, :weapon
    end
  end
end
