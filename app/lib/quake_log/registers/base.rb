# frozen_string_literal: true

module QuakeLog
  module Registers
    class Base
      include Service

      def initialize(game, line)
        @game = game
        @line = line
      end

      private

      def line_values
        @line_values ||= line.match(expression).to_a.drop(1)
      end

      def expression
        raise NotImplementedError
      end

      attr_reader :game, :line
    end
  end
end
