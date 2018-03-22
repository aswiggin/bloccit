 FactoryGirl.define do
   pw = RandomData.random_sentence
 # declare the name of the factory 
   factory :user do
     name RandomData.random_name
 # each user that the factory builds will have a unique email, using sequence 
     sequence(:email){|n| "user#{n}@factory.com" }
     password pw
     password_confirmation pw
     role :member
   end
 end