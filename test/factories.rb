FactoryGirl.define do
  factory :user do
    sequence(:login, 'aaa') { |n| "dat12#{n}" }
  end
end
