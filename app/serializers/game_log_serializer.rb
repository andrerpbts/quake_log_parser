# frozen_string_literal: true

class GameLogSerializer < ApplicationSerializer
  attributes :id, :total_kills, :players, :kills
end
