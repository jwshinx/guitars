FactoryBot.define do
  factory :guitar do
    sequence(:name) { |i| "myguitar-#{i}" }
    sequence(:price) { |i| 500 + i }
  end
end
