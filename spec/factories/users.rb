include RandomData

FactoryGirl.define do
pw = RandomData.random_sentence
  factory :user do
    username RandomData.random_name
    sequence(:email){|n| "users#{n}@factory.com" }
    password pw
    password_confirmation pw
    # role :member
    # username "Test User"
    # email "test@example.com"
    # password "helloworld"
    # password_confirmation "helloworld"
  end
end
