# Create a unique regressor for each make:model.
# Predict price from mileage and model.
# Create single average price that ignores all other features in order to generate simple regression line
# Future expansion could include additional training features like quality,
# but this requires more complexity to show a single curve when search doesn't filter by quality

# Can a single regressor predict across all model types?

#Import packages
require 'daru'
require 'ruby-fann'
require 'csv'

# Gather pre-cleaned data
full_dataset = Daru::DataFrame.from_csv "db/data/cleaned_car_prices_10k.csv", { headers: true, header_converters: CSV::HeaderConverters[:symbol] }

# Isolate data to particular model
df = full_dataset[:model, :odometer, :sellingprice]
model_name = 'Outback'
model_df = df.filter(:row) do |row|
  row[:model] == model_name
end

# split testing and training
#tts = 0.8
#size = model_df.size

# Gather inputs and outputs and scale
input_max = model_df[:odometer].max.to_f
inputs = model_df[:odometer].to_a.map { |row| [row.to_f / input_max] }

output_max = model_df[:sellingprice].max.to_f
outputs = model_df[:sellingprice].to_a.map { |row| [row.to_f / output_max] }

# train model
train = RubyFann::TrainData.new(inputs: inputs, desired_outputs: outputs)
model_fann = RubyFann::Standard.new(num_inputs: 1, hidden_neurons: [200], num_outputs: 1)
model_fann.train_on_data(train, 10000, 100, 0.001)

raw_predictions = model_fann.run(0.step(by: 0.01, to: 1.0).to_a)
predictions = raw_predictions.map { |pred| pred * output_max}

# Save model
model_location = "db/ml/v1"
model_fann.save("#{model_location}/#{model_name}.net")

# Load model and predict
loaded_model = RubyFann::Standard.new(filename: 'Outback.net')
prediction = loaded_model.run([0.5])
