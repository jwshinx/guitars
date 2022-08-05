require 'rails_helper'

describe Guitar, type: :model do
  describe 'given valid guitar' do
    it 'should be valid' do
      guitar = build(:guitar)
      expect(guitar).to be_valid
    end
  end

  describe 'given guitar with invalid price' do
    it 'should not be valid' do
      guitar = build(:guitar, price: -33)
      expect(guitar).not_to be_valid
    end
  end

  describe 'given guitar with invalid name' do
    it 'should not be valid' do
      guitar = build(:guitar, name: '')
      expect(guitar).not_to be_valid
    end
  end
end
