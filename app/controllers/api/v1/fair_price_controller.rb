class Api::V1::FairPriceController < ApplicationController

  def predict
    ml = MlModel.load_MlModel(prediction_params[:model])
    if ml
      predictions = ml.predict_price_from_mileage(prediction_params[:mileage])
      response = json_response(FairPriceSerializer.format_ml(ml, predictions, prediction_params[:mileage]))
    else
      ErrorsSerializer
    end
  end

  private

  def prediction_params
    if (params.keys & ['mileage', 'model']).all?
      clean_params = {}
      clean_params[:model] = params[:model]
      clean_params[:mileage] = params[:mileage].map { |m| m.to_f  }
      return clean_params
    else
      return nil
    end
  end
end
