class FairPriceSerializer
  def self.format_ml(ml, predictions, inputs)
    { data: {
              id: ml.file_name,
              type: 'fair_price_prediction',
              attributes: {
                predictions: predictions,
                inputs: inputs
              }
            }
    }
  end
end
