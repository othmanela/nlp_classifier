class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer :category_id
      t.string :source_url
      t.string :title
      t.text :content
    end
  end
end
