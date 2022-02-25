FactoryBot.define do
  factory :listing do
    year { Faker::Vehicle.year }
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make) }
    trim { Faker::Vehicle.style }
    body { Faker::Vehicle.car_type }
    transmission { Faker::Vehicle.transmission }
    vin { Faker::Vehicle.vin }
    state { Faker::Address.state_abbr }
    condition { Faker::Number.between(from: 0.0, to: 5.0).round(2) } 
    odometer { Faker::Vehicle.milage }
    color { Faker::Vehicle.color }
    interior { Faker::Lorem.sentence }
    sellingprice { Faker::Commerce.price }
  end
end
