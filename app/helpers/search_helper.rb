module SearchHelper
  def getLanguageURL language
    imgSrc = ''
    case language
      when "Ruby"
        imgSrc = 'http://www.blackberrycool.com/wp-content/uploads/2009/10/ruby-300x300.png'
      else
        imgSrc = 'http://www.blackberrycool.com/wp-content/uploads/2009/10/ruby-300x300.png'
    end 

    return imgSrc
  end
end

