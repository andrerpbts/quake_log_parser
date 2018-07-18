# frozen_string_literal: true

module QuakeLog
  module Entities
    class Kill
      include Virtus.model

      attribute :killer, Player
      attribute :killed, Player
      attribute :weapon, String
    end
  end
end
