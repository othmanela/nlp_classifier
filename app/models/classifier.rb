class Classifier
  def self.classify(article)
    puts self.classifications(article).sort_by { |a| -a[1] }.inspect
    (self.classifications(article).sort_by { |a| -a[1] })[0][0]
  end

  def self.classifications(article)
    score = Hash.new
    text = article.split
    Category.all.each do |category|
      score[category.name] = 0
      results = category.results
      total   = results.sum :count
      word_count(text).each do |word, count|
        r = Result.find_by word: word
        if r 
          s = r.count
        else
          s = 0.1
        end
        score[category.name] += Math.log(s/total.to_f) if total.to_f != 0
      end
    end
    puts score.inspect
    return score
  end

  def self.word_count(words)
    words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
  end
end