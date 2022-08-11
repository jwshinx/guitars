require 'rails_helper'

RSpec.describe Unit, type: :model do
  let!(:guitar) { create(:guitar) }
  let!(:store) { create(:store) }

  describe 'given valid unit' do
    it 'should be valid' do
      unit = build(:unit, guitar: guitar, store: store, quantity: 2)
      expect(unit).to be_valid
    end
  end

  describe 'given unit with no store reference' do
    it 'should not be valid' do
      unit = build(:unit, guitar: guitar, store: nil)
      expect(unit).not_to be_valid
      expect(unit.errors[:store]).to include(/must exist/)
    end
  end

  describe 'given unit with no guitar reference' do
    it 'should not be valid' do
      unit = build(:unit, store: store, guitar: nil)
      expect(unit).not_to be_valid
      expect(unit.errors[:guitar]).to include(/must exist/)
    end
  end

  describe 'given store with invalid quantity' do
    it 'should not be valid' do
      unit = build(:unit, store: store, guitar: guitar, quantity: -1)
      expect(unit).not_to be_valid
      expect(unit.errors[:quantity]).to include(/must be greater than or equal to 0/)
    end
  end
end
