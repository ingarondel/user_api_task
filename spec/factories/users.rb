FactoryBot.define do
  factory :user do
    name { "Inga" }
    patronymic { "Ingovna" }
    email { "inga@gmail.com" }
    nationality { "idk" }
    country { "Somewhere" }
    gender { "female" }
    age { 21 }

    after(:create) do |user|
      user.interests << create(:interest, name: "Coding")
      user.skills << create(:skill, name: "Ruby")
    end

    trait :invalid do
      name { nil }
    end
  end
end
