class Guitar < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, :numericality => { greater_than: 0 }

  has_many :units
  has_many :stores, through: :units
end
