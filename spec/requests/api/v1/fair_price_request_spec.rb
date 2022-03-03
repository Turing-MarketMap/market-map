require 'rails_helper'

RSpec.describe 'fair price api' do
  describe 'api/v1/fair_price' do
    context 'request is valid' do
      let!(:name) {'Impreza'}
      let!(:mileage) { [10000,50000] }
      let!(:ml) { MlModel.load_MlModel(name) }
      let!(:query) { "?model=#{name}&mileage[]=#{mileage[0]}&mileage[]=#{mileage[1]}" }

      it "gets an array of prediction values" do
        get "/api/v1/fair_price#{query}"
        json = parse_json
        data = json[:data]

        expect(response).to be_successful
        expect(data).to be_a(Hash)
        expect(data.keys).to eq([:id, :type, :attributes])
        expect(data[:attributes].keys).to eq([:predictions, :inputs])
        expect(data[:attributes][:inputs]).to eq(mileage)
        expect(data[:type]).to eq('fair_price_prediction')
        expect(data[:id]).to eq(name)
      end
    end
  end
end
