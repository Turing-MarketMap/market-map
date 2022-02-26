class ListingSerializer 
  include JSONAPI::Serializer 
  attributes :year, 
             :make, 
             :model, 
             :trim, 
             :body, 
             :transmission, 
             :vin, 
             :state, 
             :condition, 
             :odometer, 
             :color, 
             :interior, 
             :sellingprice
end