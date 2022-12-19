FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 3..10) }
    password { 'mypass' }
  end
 end