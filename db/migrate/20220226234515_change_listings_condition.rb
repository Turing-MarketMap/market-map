class ChangeListingsCondition < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :condition, 'float USING CAST(condition AS float)'
  end
end
