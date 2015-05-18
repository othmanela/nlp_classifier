class AddTranslatedNameToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :translated_name, :string
  end
end
