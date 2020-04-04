FactoryBot.define do
  factory :post do
    sequence(:name) { |n| "#{n}test_name"}
    sequence(:content) { |n| "テストコンテンツ#{n}" }
    sequence(:post_date) { DateTime.current }
    
    ## この部分を追加↓
    trait :invalid do
      name { nil }
    end
    ##
    
  end
  
end