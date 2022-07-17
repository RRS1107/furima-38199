FactoryBot.define do
  factory :item do
    name                           {Faker::Commerce.product_name}
    introduction                   {Faker::Lorem.sentence}
    price                          {Faker::Number.between(from: 300, to: 9_999_999)}
    condition_id                   {Faker::Number.between(from: 2, to: 7)}
    preparation_day_id             {Faker::Number.between(from: 2, to: 4)}
    prefecture_id                  {Faker::Number.between(from: 2, to: 48)}
    postage_type_id                {Faker::Number.between(from: 2, to: 3)}
    category_id                    {Faker::Number.between(from: 2, to: 11)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
