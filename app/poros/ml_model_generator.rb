class MlModelGenerator
  require 'daru'
  require 'ruby-fann'
  require 'csv'

  def self.get_car_data(file_path)
    # Gather pre-cleaned data
    full_dataset = Daru::DataFrame.from_csv file_path, { headers: true, header_converters: CSV::HeaderConverters[:symbol] }
    df = full_dataset[:model, :odometer, :sellingprice]
  end


  def self.create_ml(file_name, data)
    ml = MlModel.new(file_name, model_data)
    ml.train()
    ml.save
  end


  def self.create_ml_for_all_models(file_path)
    df = MlModelGenerator.get_car_data(file_path)
    models = df.unique(:model)[:model].to_a

    models.each do |model_name|
      model_data = data.filter(:row) do |row|
        row[:model] == model_name
      end
      MlModelGenerator.create_ml(model_name, model_data)
    end
  end


  def self.create_ml_for_model(model_name, file_path)
    df = MlModelGenerator.get_car_data(file_path)
    model_data = data.filter(:row) do |row|
      row[:model] == model_name
    end
    MlModelGenerator.create_ml(model_name, model_data)
  end
end
