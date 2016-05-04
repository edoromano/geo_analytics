FactoryGirl.define do
  factory :house do
    description { FFaker::AddressMX.municipality }
    price { rand() * 100 }
    published false
    latitude { FFaker::Geolocation.lat }
    longitude { FFaker::Geolocation.lng }
    user
  end
end
