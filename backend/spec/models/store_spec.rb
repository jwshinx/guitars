require 'rails_helper'

describe Store, type: :model do
  describe 'given valid store' do
    it 'should be valid' do
      store = build(:store)
      expect(store).to be_valid
    end
  end

  describe 'given store with invalid name' do
    it 'should not be valid' do
      store = build(:store, name: nil)
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include(/is too short/)
      expect(store.errors[:name]).to include(/can't be blank/)
    end
  end

  describe 'given store with short name' do
    it 'should not be valid' do
      store = build(:store, name: 'x')
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include(/is too short/)
    end
  end
end
