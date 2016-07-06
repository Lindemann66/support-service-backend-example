FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "customer#{n}@email.ru" }
    password Encryptor.encrypt("password")
    role User::CUSTOMER_ROLE_ID

    trait :support do
      role User::SUPPORT_ROLE_ID
    end
  end
end
