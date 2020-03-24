FactoryBot.define do
  factory :user do
    username { Faker::Name.name[0..9] }
  end
end
