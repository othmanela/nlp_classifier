class CreateComplements < ActiveRecord::Migration
  def change
    create_table :complements do |t|
      t.integer :category_id
      t.string :word
      t.integer :count
      t.float :tfidf
      t.float :weight
      t.float :normalized_weight
    end
  end
end
