FactoryBot.define do
  factory :customer do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    after(:build) do |customer|
      customer.profile_image.attach(io: File.open('spec/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'application/xlsx')
    end
  end
end