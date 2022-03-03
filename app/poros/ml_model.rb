class MlModel
  require 'daru'
  require 'ruby-fann'
  require 'csv'

  attr_accessor :file_name, :net, :inputs, :outputs, :input_max, :output_max

  # accept daru dataframe inputs and outputs and auto-format data
  def initialize(file_name, data = nil)
    @file_name = file_name
    if data[:odometer] && data[:sellingprice]
      @input_max = data[:odometer].max.to_f
      @output_max = data[:sellingprice].max.to_f

      @inputs = data[:odometer].to_a.map { |row| [row.to_f / input_max] }
      @outputs = data[:sellingprice].to_a.map { |row| [row.to_f / output_max] }
    end
    @net = nil
  end

  def train(neurons = 200, epochs = 10000, report_rate = 100, mse_target = 0.001)
    train_data = RubyFann::TrainData.new(inputs: @inputs, desired_outputs: @outputs)
    @net = RubyFann::Standard.new(num_inputs: 1, hidden_neurons: [neurons], num_outputs: 1)
    @net.train_on_data(train_data, epochs, report_rate, mse_target)
  end

  def save
    model_location = "db/ml/v1/models"
    max_data_location = "db/ml/v1/max_data"
    @net.save("#{model_location}/#{@file_name}.net")
    File.write("#{max_data_location}/#{@file_name}_max_data.csv", [['input max', 'output max'],[@input_max, @output_max]].map(&:to_csv).join)
  end

  def load_net(filename)
    location = "db/ml/v1/models"
    @net = RubyFann::Standard.new(filename: "#{location}/#{filename}.net")
  end

  def predict(input)
    @net.run([input]) * @output_max
  end

  # load trained model and max_data and create new MlModel object.
  def self.load_MlModel(file_name)
    model_location = "db/ml/v1/models"
    max_data_location = "db/ml/v1/max_data"

    new_model = MlModel.new(file_name)
    new_model.file_name = file_name
    new_model.net = RubyFann::Standard.new(filename: "#{location}/#{filename}.net")

    max_data = CSV.read("#{max_data_location}/#{file_name}_max_data.csv")
    max_data_array = CSV.parse(max_data)

    new_model.input_max = max_data_array[1][0]
    new_model.output_max = max_data_array[1][1]
  end
end
