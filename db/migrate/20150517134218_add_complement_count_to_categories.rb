class AddComplementCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :complement_count, :integer
  end
end
