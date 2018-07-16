# frozen_string_literal: true

class GameLog < ApplicationRecord
  validates :total_kills, :players, :kills, presence: true
end
