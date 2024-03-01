FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
  end

  factory :friendship do
    user_id { 1 }
    friend_id { 2 }
  end
end
