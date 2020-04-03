FactoryBot.define do
  factory :group do
    user
    name { 'Group by Factorybot' }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/mac.jpeg'), 'image/jpeg') }
  end
end
