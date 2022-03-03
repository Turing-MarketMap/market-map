require 'rails_helper'

RSpec.describe 'ml_model' do
  let!(:full_dataset) { full_dataset = Daru::DataFrame.from_csv file_path, { headers: true, header_converters: CSV::HeaderConverters[:symbol] } }
  let!(:df) { full_dataset[:model, :odometer, :sellingprice]}
  let!(:model_data) { data.filter(:row) { do |row| row[:model] == model_name }
  let!(:ml) { MlModel.new('Outback', model_data) }
  let!(:loaded_ml) {MlModel.load_MlModel('Outback')}

  it "exists" do
    expect(ml).to be_a(MlModel)
    expect(ml.file_name).to eq('Outback')
    expect(ml.input_max).to be_a(Float)
    expect(ml.output_max).to be_a(Float)
    expect(ml.input_max).to be_a(Array)
    expect(ml.output_max).to be_a(Array)
    expect(ml.input_max.sample(1)[0]).to be_a(Float)
    expect(ml.output_max.sample(1)[0]).to be_a(Float)
    expect(ml.net).to eq(nil)
  end

  describe 'load_MlModel' do
    it "loads an MlModel" do
      expect(loaded_ml).to be_a(MlModel)
    end

    it "has expected attributes pre-loaded" do
      expect(loaded_ml.net).to_not eq(nil)
      expect(loaded_ml.file_name).to eq('Outback')
      expect(loaded_ml.input_max).to be_a(Float)
      expect(loaded_ml.output_max).to be_a(Float)
      expect(loaded_ml.inputs).to eq(nil)
      expect(loaded_ml.outputs).to eq(nil)
    end
  end

  describe 'predict_price_from_mileage' do
    it "returns correct prediction" do
      expect(loaded_model.predict_price_from_mileage(40000)).to be_a(Float)
    end
  end
end
