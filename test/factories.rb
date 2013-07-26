FactoryGirl.define do
  factory :user do
    sequence(:login, 'aaa') { |n| "dat12#{n}" }
    password 'secret'
  end

  factory :item do
    name 'Linear Algebra'
  end
end
