class Category < ActiveRecord::Base
  has_many :data
  has_many :results 
  has_many :complements
end
