FactoryBot.define do
  factory :diary_book do
    title { Faker::Lorem.characters(number:10) }
    customer
  end
end