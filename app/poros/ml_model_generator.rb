class MlModelGenerator
  require_relative 'ml_model'
  require 'daru'
  require 'ruby-fann'
  require 'csv'

  # Gather pre-cleaned data
  def self.get_car_data(file_path)
    full_dataset = Daru::DataFrame.from_csv file_path, { headers: true, header_converters: CSV::HeaderConverters[:symbol] }
    df = full_dataset[:model, :odometer, :sellingprice]
  end

  # Create MlModel object, train using default settings, save .net file, and save max data csv.
  def self.create_ml(file_name, data)
    ml = MlModel.new(file_name, data)
    ml.train()
    ml.save
  end

  # iterate through all model types in database and generate a regressor for each
  def self.create_ml_for_all_models(file_path)
    df = MlModelGenerator.get_car_data(file_path)
    models = df.uniq(:model)[:model].to_a

    models.each do |model_name|
      model_data = df.filter(:row) do |row|
        row[:model] == model_name
      end
      MlModelGenerator.create_ml(model_name, model_data)
    end
  end

  # Generate a regressor for a single model type
  def self.create_ml_for_model(model_name, file_path)
    df = MlModelGenerator.get_car_data(file_path)
    model_data = df.filter(:row) do |row|
      row[:model] == model_name
    end
    MlModelGenerator.create_ml(model_name, model_data)
  end

  # Include pry to allow CLI access to functions. 
  require "pry"; binding.pry
end
