7.times do |n|
  username  = Faker::Name.name[0..9].split(' ').join('').downcase
  User.create!(username:  username)
end

users = User.all
count = 10
users.each do |user|
  name = Faker::Lorem.sentence
  user.transactions.create!(name: name,
                            amount: count)
  count = count + 10
end

users.each do |user|
  name = Faker::Company.name
  user.groups.create!(name: name)
end

transactions = Transaction.order(:created_at).take(2)
first_group = Group.find(1)
transactions.each do |transaction|
  first_group.transactions << transaction
end

groups = Group.order(:created_at).take(3)
first_transaction = Transaction.find(1)
groups.each do |group|
  first_transaction.groups << group
end