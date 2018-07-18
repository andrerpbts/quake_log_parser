# frozen_string_literal: true

module QuakeLog
  module Entities
    class Player
      include Virtus.model

      attribute :name, String
      attribute :kills, Integer, default: 0
    end
  end
end
