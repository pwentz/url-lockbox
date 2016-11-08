FactoryGirl.define do
  factory :user do
    email_address 'bob@gmail.com'
    password 'password'
  end

  factory :link do
    url 'https://github.com'
    title 'Github'
    read false
  end
end
