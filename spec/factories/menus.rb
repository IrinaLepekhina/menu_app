FactoryBot.define do
  factory :menu do
    sequence(:title) { |n| "Menu #{n}"}
    date { DateTime.new(2023,12,31) }
  end
end