FactoryBot.define do
  factory :notification do
  end

  factory :comment do
    association :user
    commentable { create(:post) }
    contents { Faker::TvShows::TheExpanse.quote }

    trait :with_post do
      commentable { create(:post) }
    end

    trait :with_comment do
      commentable { create(:comment) }
    end

    
  end

  factory :like do
  end

  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
  end

  factory :friendship do
    user_id { 1 }
    friend_id { 2 }
  end

  factory :post do
    association :user
    body { Faker::TvShows::TheExpanse.quote }
  end
end
