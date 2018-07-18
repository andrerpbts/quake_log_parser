# frozen_string_literal: true

module Service
  extend ActiveSupport::Concern

  included do
    def call
      raise NotImplementedError
    end
  end

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end
end
