FactoryBot.define do
  factory :unit do
    association :guitar, factory: :guitar
    association :store, factory: :store
    sequence(:quantity) { |x| x }
  end
end
