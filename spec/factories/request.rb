FactoryGirl.define do
  factory :request do
    sequence(:text) { |n| "Request text {n}" }
    status Request::PENDING_STATUS
    association :user
  end
end
