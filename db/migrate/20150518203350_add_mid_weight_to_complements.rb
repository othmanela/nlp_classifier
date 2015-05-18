class AddMidWeightToComplements < ActiveRecord::Migration
  def change
    add_column :complements, :mid_weight, :float
  end
end
