FactoryBot.define do
  factory :store do
    sequence(:name) {|i| "my-store-#{i}" }
    active { true }
  end
end
