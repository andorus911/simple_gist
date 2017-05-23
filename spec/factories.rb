FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "qwerty"
    password_confirmation "qwerty"

    factory :admin do
      admin true
    end
  end

  factory :snippet do
    title "hello.rb"
    content "puts \"Hello, world!\""
    user
  end
end