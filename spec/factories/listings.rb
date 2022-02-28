FactoryBot.define do
  factory :listing do
    year { Faker::Vehicle.year }
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: make) }
    trim { Faker::Vehicle.style }
    body { Faker::Vehicle.car_type }
    transmission { Faker::Vehicle.transmission }
    vin { Faker::Vehicle.vin }
    state { Faker::Address.state_abbr }
    condition { Faker::Number.between(from: 0.0, to: 5.0).round(2) }
    odometer { Faker::Number.between(from: 0, to: 250000) }
    color { Faker::Vehicle.color }
    interior { Faker::Lorem.sentence }
    sellingprice { Faker::Number.within(range: 2000..40000) }
    # sellingprice { Faker::Number.within(range: 20000..40000) * ((250000 - odometer ) / 250000.0).to_i } # Deprecate value based on mileage for more realistic fake prices
  end
end
