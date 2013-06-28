FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "dat#{n}sek" }
    password 'secret'
  end
end
