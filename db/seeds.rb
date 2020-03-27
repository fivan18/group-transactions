username  = Faker::Name.name[0..9].split(' ').join('').downcase
User.create!(username:  username)

user = User.find(1)
count = 10
4.times do
  name = Faker::Lorem.sentence
  user.transactions.create!(name: name,
                            amount: count)
  count = count + 10
end

2.times do
  name = Faker::Company.name
  user.groups.create!(name: name)
end

user.transactions.take(2).each do |transaction|
  user.groups.first.transactions << transaction
end