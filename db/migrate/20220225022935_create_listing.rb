class CreateListing < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.string :trim
      t.string :body
      t.string :transmission
      t.string :vin
      t.string :state
      t.string :condition
      t.integer :odometer
      t.string :color
      t.string :interior
      t.integer :sellingprice

      t.timestamps
    end
  end
end
