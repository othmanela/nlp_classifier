namespace :twcnb do
  task :calc_count_df => :environment do
    categories = Category.all
    categories.each do |category|
      data = category.data 
      data.each do |article|
        text = article.title + article.content
        clean_text = NlpArabic.wash_and_stem(text).split
        clean_text.each do |word|
          result = Result.where(category_id: category.id, word: word).first
          if result
            result.increment! :count
          else 
            Result.create(category_id: category.id, word: word, count: 1.to_i)
          end
          unique_word = Word.where(word: word).first
          if unique_word
            unique_word.increment! :df
          else 
            Word.create(word: word, df: 1.to_i)
          end
        end
      end
    end
  end

  task :calc_idf => :environment do
    articles_count = Datum.all.size
    words = Word.all
    words.each do |word|
      word.idf = Math.log(1.0 * articles_count / word.df)
      word.save
    end
  end

  task :calc_category_word_count => :environment do
    categories = Category.all
    categories.each do |category|
      category_words = category.results
      category_words.each do |word|
        tfidf = Math.log(word.count + 1)
        idf_word = Word.where(word: word).first
        tfidf *= idf_word.idf if idf_word
        word.tfidf = tfidf
        word.save
      end
      sum = 0
      category_words.each do |word|
        sum += word.tfidf ** 2
      end
      document_length = Math.sqrt(sum)
      category_words.each do |word|
        count = word.tfidf
        count /= document_length
        word.tfidf += count
        word.save
      end
    end
  end

  task :calc_complement_category_count => :environment do
    categories = Category.all
    categories.each do |category|
      category.count = category.data.size
      category.complement_count = Datum.all.size - category.count
      category.save
    end
  end

  task :calc_category_word_tfidf => :environment do
    alpha = Result.all.size 
    categories = Category.all
    categories.each do |category|
      theta_denominator = category.results.sum(:tfidf) + alpha
      category_words = category.results
      category_words.each do |word|
        theta = (word.tfidf + 1) / theta_denominator
        word.weight = Math.log(theta)
        word.save
      end
    end
  end

  task :calc_normalized_category_word_tfidf => :environment do
    categories = Category.all
    categories.each do |category|
      category_words = category.results
      weight_sum = category_words.map{ |r| Math.log(r.tfidf.abs)}.sum
      category_words.each do |word|
        word.normalized_weight = Math.log(word.tfidf) / weight_sum
        word.save
      end
    end
  end

  task :calc_complement_category_word_count => :environment do
    alpha = Result.all.size 
    categories = Category.all
    words = Word.all
    words.each do |word|
      categories.each do |category|
        complement = Complement.where(category_id: category.id, word: word.word).first
        # puts complement.inspect
        if complement
          complement_weight = Complement.where("category_id != ? AND word = ?", category.id, word.word).sum(:tfidf)
          complement.weight = complement_weight if complement_weight
          complement.save
        else
          complement_weight = Complement.where("category_id != ? AND word = ?", category.id, word.word).sum(:tfidf)
          Complement.create(category_id: category.id, word: word, weight: complement_weight )
        end
      end
    end
  end

  task :calc_category_word_weight => :environment do
    alpha = Result.all.size 
    categories = Category.all
    categories.each do |category|
      theta_denominator = category.complements.sum(:weight) + alpha
      category_words = category.complements
      category_words.each do |word|
        theta = (word.weight + 1) / theta_denominator
        word.mid_weight = Math.log(theta)
        word.save
      end
    end
  end

  task :calc_normalized_category_word_weight => :environment do
    categories = Category.all
    categories.each do |category|
      category_words = category.complements
      weight_sum = category_words.map{ |r| r.mid_weight.abs}.sum
      category_words.each do |word|
        word.normalized_weight = word.mid_weight / weight_sum
        word.save
      end
    end
  end
end