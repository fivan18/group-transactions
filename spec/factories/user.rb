FactoryBot.define do
  factory :user do
    username { Faker::Name.name[0..9].split(' ').join('') }
    password { 'password' }
    password_confirmation { 'password' }

    factory :user_with_external_transactions do
      transient do
        transactions_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:transaction, evaluator.transactions_count, user: user)
      end
    end

    factory :user_with_groups do
      transient do
        groups_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:group, evaluator.groups_count, user: user)
      end
    end
  end
end
