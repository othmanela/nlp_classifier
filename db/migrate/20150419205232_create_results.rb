class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :category_id
      t.string :word
      t.integer :count
    end
  end
end
