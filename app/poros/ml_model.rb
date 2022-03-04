class MlModel
  require 'daru'
  require 'ruby-fann'
  require 'csv'

  attr_accessor :file_name, :net, :inputs, :outputs, :input_max, :output_max

  # accept daru dataframe inputs and outputs and auto-format data
  def initialize(file_name, data = nil)
    @file_name = file_name
    if data && data[:odometer] && data[:sellingprice]
      # get max from data for data normalization
      @input_max = data[:odometer].max.to_f
      @output_max = data[:sellingprice].max.to_f

      #scale data: Default training settings requires that all values be normalized (between 0 and 1).
      @inputs = data[:odometer].to_a.map { |row| [row.to_f / input_max] }
      @outputs = data[:sellingprice].to_a.map { |row| [row.to_f / output_max] }
    end
    @net = nil
  end

  def train(neurons = 200, epochs = 10000, report_rate = 100, mse_target = 0.001)
    #Based on experience, a single layer of neurons will work fine for this kind of dataframe
    # neurons = number in layer.
    # ephocs = number of times we run training data through the network.
    # Report rate = how many ephocs between accuracy CLI reports
    # mse_target = error level at which the training automatically stops
    train_data = RubyFann::TrainData.new(inputs: @inputs, desired_outputs: @outputs)
    @net = RubyFann::Standard.new(num_inputs: 1, hidden_neurons: [neurons], num_outputs: 1)
    @net.train_on_data(train_data, epochs, report_rate, mse_target)
  end

  def save
    # save the nueral net and the max data in order to scale predictions from 0-1 to a more meaningful value
    model_location = "db/ml/v2/models"
    max_data_location = "db/ml/v2/max_data"
    @net.save("#{model_location}/#{@file_name}.net")
    File.write("#{max_data_location}/#{@file_name}_max_data.csv", [['input max', 'output max'],[@input_max, @output_max]].map(&:to_csv).join)
  end

  def load_net(filename)
    location = "db/ml/v2/models"
    @net = RubyFann::Standard.new(filename: "#{location}/#{filename}.net")
  end

  def predict_price_from_mileage(input)
    # normalize input values, predict, and then scale up to match original data
    # @net.run works on a single array of input parameters, so we must loop through it once for every input we pass in.
    scaled_inputs = input.map{ |mileage| [mileage.to_f/@input_max] }
    predictions = scaled_inputs.map do |scaled_input|
      @net.run(scaled_input)[0]*output_max
    end
  end


  def self.load_MlModel(file_name)
    # load trained model and max_data and return new MlModel object.
    # this object will not have the raw data used for training, but it will be able to make predictions.
    model_location = "db/ml/v1/models"
    max_data_location = "db/ml/v1/max_data"

    new_model = MlModel.new(file_name)
    new_model.file_name = file_name
    new_model.net = RubyFann::Standard.new(filename: "#{model_location}/#{file_name}.net")

    max_data = CSV.read("#{max_data_location}/#{file_name}_max_data.csv")

    new_model.input_max = max_data[1][0].to_f
    new_model.output_max = max_data[1][1].to_f
    new_model
  end
end
