include RandomData

FactoryGirl.define do
  factory :bookmark do
    url RandomData.random_url
    topic
  end
end
