require 'rails_helper'

RSpec.describe 'listing model' do
  let!(:listing_1) { build_list(:listing, 100) }

  describe 'class methods' do
    describe 'get_makes' do
      it "returns an array of makes that are in the listings database" do
        expect(Listing.get_makes).to be_a(Array)
        # expect(Listing.get_makes).to eq(["Acura",
        #                                 "airstream",
        #                                 "Aston Martin",
        #                                 "Audi",
        #                                 "Bentley",
        #                                 "BMW",
        #                                 "Buick",
        #                                 "Cadillac",
        #                                 "chev truck",
        #                                 "Chevrolet",
        #                                 "Chrysler",
        #                                 "Daewoo",
        #                                 "Dodge",
        #                                 "dodge tk",
        #                                 "dot",
        #                                 "Ferrari",
        #                                 "FIAT",
        #                                 "Fisker",
        #                                 "Ford",
        #                                 "ford tk",
        #                                 "ford truck",
        #                                 "Geo",
        #                                 "GMC",
        #                                 "gmc truck",
        #                                 "Honda",
        #                                 "HUMMER",
        #                                 "Hyundai",
        #                                 "hyundai tk",
        #                                 "Infiniti",
        #                                 "Isuzu",
        #                                 "Jaguar",
        #                                 "Jeep",
        #                                 "Kia",
        #                                 "Lamborghini",
        #                                 "Land Rover",
        #                                 "landrover",
        #                                 "Lexus",
        #                                 "Lincoln",
        #                                 "Lotus",
        #                                 "Maserati",
        #                                 "Mazda",
        #                                 "mazda tk",
        #                                 "mercedes",
        #                                 "mercedes-b",
        #                                 "Mercedes-Benz",
        #                                 "Mercury",
        #                                 "MINI",
        #                                 "Mitsubishi",
        #                                 "Nissan",
        #                                 "Oldsmobile",
        #                                 "plymouth",
        #                                 "pontiac",
        #                                 "Porsche",
        #                                 "Ram",
        #                                 "Rolls-Royce",
        #                                 "Saab",
        #                                 "Saturn",
        #                                 "Scion",
        #                                 "smart",
        #                                 "Subaru",
        #                                 "Suzuki",
        #                                 "Tesla",
        #                                 "Toyota",
        #                                 "Volkswagen",
        #                                 "Volvo",
        #                                 "vw"]
        #                               )
      end
    end

    describe 'get_make_models_hash' do
      xit "returns a hash of all the make/model combinations in the listings database" do
        expect(Listing.get_make_models_hash).to be_a(Hash)
        expect(Listing.get_make_models_hash.keys).to eq(Listing.get_makes)
        random_key = Listing.get_makes.sample(1)[0]
        expect(Listing.get_make_models_hash[random_key]).to be_a(Array)
      end
    end

    describe 'get_models' do
      xit "returns an array of all of the models in the database associated with the given make" do
        make = Listing.get_makes.sample(1)[0]
        expect(Listing.get_models(make)).to be_a(Array)
      end
    end
  end
end
