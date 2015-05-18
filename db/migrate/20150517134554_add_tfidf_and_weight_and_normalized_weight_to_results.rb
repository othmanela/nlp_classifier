class AddTfidfAndWeightAndNormalizedWeightToResults < ActiveRecord::Migration
  def change
    add_column :results, :tfidf, :float
    add_column :results, :weigth, :float
    add_column :results, :normalized_weight, :float
  end
end
