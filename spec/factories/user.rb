FactoryGirl.define do
  FAKE_PASSWD = 'fake_passwd'.freeze

  factory :user do
    email Faker::Internet.unique.email
    password FAKE_PASSWD
    password_confirmation FAKE_PASSWD
  end
end
