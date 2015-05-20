class Twcnb
  def self.classify(document)
    clean_text = NlpArabic.wash_and_stem(document).split
    categories = Category.all
    scores = Hash.new
    categories.each do |category|
      scores[category] = calc_score(clean_text,category)
    end
    best_category = scores.min_by{|k,v| v}[0]
    return best_category
  end
  
  def self.calc_score(clean_text, category)
    score = 0
    word_count = clean_text.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    word_count.each do |word, count|
      result_word = Complement.where(category_id: category.id, word: word).first
      if result_word
        word_weight = result_word.normalized_weight
        score += count * word_weight
      end
    end
    return score
  end
end