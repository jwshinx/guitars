class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :active, inclusion: [true, false], exclusion: [nil]

  has_many :units, inverse_of: :store, dependent: :destroy
  has_many :guitars, through: :units
end
