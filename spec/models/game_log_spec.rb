require 'rails_helper'

RSpec.describe GameLog, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:total_kills) }
    it { is_expected.to validate_presence_of(:players) }
    it { is_expected.to validate_presence_of(:kills) }
  end
end
