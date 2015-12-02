include RandomData

FactoryGirl.define do
  factory :topic do
    title RandomData.random_name
  end
end
