class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :active, inclusion: [ true, false ]

  has_many :units
  has_many :guitars, through: :units
end
