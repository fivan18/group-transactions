require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations to test' do
    it { should validate_presence_of(:name) }
    it do
      should validate_length_of(:name).
      is_at_least(6).is_at_most(30)
    end
  end
  describe 'associations to test' do
    it { should belong_to(:user).required }
    it { should have_many(:groups) }
  end
end
