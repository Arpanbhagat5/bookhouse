FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    category { create(:category) }
    price { Faker::Commerce.price(range: 0..100) }
  end
end
