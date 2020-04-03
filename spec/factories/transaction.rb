FactoryBot.define do
  factory :transaction do
    user
    name { 'Transaction by Factorybot' }
    amount { Faker::Number.number(2) }

    factory :transaction_with_groups do
      transient do
        groups_count { 1 }
      end

      after(:create) do |transaction, evaluator|
        create_list(:group, evaluator.groups_count, transactions: [transaction])
      end
    end
  end
end
