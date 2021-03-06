require 'csv'

desc "Import listings from csv"
task :import_listings_csv => [:environment] do
  file = "db/data/cleaned_car_prices_10k.csv"

  CSV.foreach(file, :headers => true) do |row|

      year = row[0]
      make = row[1]
      model = row[2]
      trim = row[3]
      body = row[4]
      transmission = row[5]
      vin = row[6]
      state = row[7]
      condition = row[8].to_f
      odometer = row[9]
      color = row[10]
      interior = row[11]
      sellingprice = row[14]

      Listing.create!(year: year,
                      make: make,
                      model: model,
                      trim: trim,
                      body: body,
                      transmission: transmission,
                      vin: vin,
                      state: state,
                      condition: condition,
                      odometer: odometer,
                      color: color,
                      interior: interior,
                      sellingprice: sellingprice)

  end

  ActiveRecord::Base.connection.reset_pk_sequence!('listings')
end
