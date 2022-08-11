class Unit < ApplicationRecord
  belongs_to :guitar
  belongs_to :store

  validates_uniqueness_of :store_id, scope: :guitar_id
  validates :quantity, presence: true, :numericality => {
    greater_than_or_equal_to: 0,
    only_integer: true
  }
end
