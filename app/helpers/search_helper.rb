module SearchHelper
  def getLanguageURL language
    case language
      when "Ruby"
        imgSrc = 'ruby.png'
      when "Python"
        imgSrc = 'python.png'
      when "JavaScript"
        imgSrc = 'js.png'
      when "Java"
        imgSrc = 'java.png'
      when "PHP"
        imgSrc = 'php.png'
      when "C++"
        imgSrc = 'cplusplus.png'
      when "C"
        imgSrc = 'c.png'
      when "CSS"
        imgSrc = 'css.png'
      when "Objective-C"
        imgSrc = 'objectivec.png'
      else
        imgSrc = 'question.png'
    end 

    return imgSrc
  end
end

