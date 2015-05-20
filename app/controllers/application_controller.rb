class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :null_session

  def index
    if params[:input_article]
      article = params[:input_article]
      if !article.blank?
        language = DetectLanguage.detect(article)
        if DetectLanguage.detect(article).any? {|h| h['language'] == 'ar'}
          @category = Twcnb.classify(article)
        else
          flash.now['notice'] = 'Please enter arabic text. Until now, the classifier has only been trained on that language.'
        end
      else
        flash.now['warning'] = 'No text has been entered. You can find arabic news articles on Euronews.' 
      end
    end
  end
end
