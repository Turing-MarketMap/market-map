FactoryBot.define do
  factory :listing do
    year { Faker::Commerce.product_name }
    make { Faker::Lorem.sentence }
    model { Faker::Commerce.price}
    trim { Faker::Commerce.price}
    body { Faker::Commerce.price}
    transmission { Faker::Commerce.price}
    vin { Faker::Commerce.price}
    state { Faker::Commerce.price}
    condition { Faker::Commerce.price}
    odometer { Faker::Commerce.price}
    color { Faker::Commerce.price}
    interior { Faker::Commerce.price}
    sellingprice { Faker::Commerce.price}

  end
end
