namespace :naive do
  task :train_data => :environment do
    Category.all.each do |category|
      category.data.each do |article|
        clean_text = NlpArabic.wash_and_stem(article.content)
        text = article.split
        category_id = category.id
        Category.find(category_id).increment! :count
        text.each do |word|
          result = Result.where(category_id: category_id, word: word).first
          if result
            result.increment! :count
          else 
            Result.create(category_id: category_id, word: word, count: 1.to_i)
          end
        end
      end
    end
  end
end