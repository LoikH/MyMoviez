FactoryGirl.define do
  factory :user do |user|
    user.username              "John Marston"
    user.email                 "john.marston@reddead.com"
    user.password              "foobar"
    user.password_confirmation "foobar"
  end
end