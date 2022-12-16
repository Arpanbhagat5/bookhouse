# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    book { create(:book) }
    title { Faker::Company.catch_phrase }
    comment { Faker::Company.catch_phrase }
  end
end
