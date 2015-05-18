class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :results, :weigth, :weight
  end
end
