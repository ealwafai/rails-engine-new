FactoryBot.define do
  factory :customer do
    name { Faker::Superhero.name }
  end
end
