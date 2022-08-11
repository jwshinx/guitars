class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :active, inclusion: [ true, false ]
end
