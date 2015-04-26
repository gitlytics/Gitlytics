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

  #Build a string of font-awesome stars for the amount of stargazers
  def buildStars stars
    toReturn =""
    #some repos with aton of stars need resized
    resize = "1 star = 1 stargazer"
    if stars > 1000
      resize = "1 star = 100 stargazers"
      stars /= 100
    else
      if stars > 500
        resize = "1 star = 10 stargazers"
        stars /= 10
      else
        if stars > 100
          resize = "1 star = 5 stargazers"
          stars /= 5
        end
      end
    end
    for i in 0..stars-1
      if i % 5 == 4 #insert a space every five
        toReturn += "<i class=\"fa fa-star\">&#160;&#160;</i>"
      else
        toReturn += "<i class=\"fa fa-star\"></i>"
      end
    end
    toReturn += "<p>" + resize + "</p>"
    toReturn.html_safe
    return toReturn
  end
  def buildReadme exists
    if exists
      return "<i class=\"fa fa-book fa-5x\"></i><p>(has a README)<\p>"
    else
      return "<span class=\"fa-stack fa-5x\"><i class=\"fa fa-book fa-stack-1x\"></i><i class=\"fa fa-ban fa-stack-2x text-danger \"></i></span><p>(Does not have a README)</p>"
    end
  end

  def buildContributors contribs
    toReturn = ""
    for i in 0..contribs.to_i - 1
      toReturn += "<img src=\"/images/programmer.png\" alt=\"1 contrib\" />"
      if i % 5 == 4 #insert a space every five
        toReturn += "<p>&#13;</p>"
      end
    end
    return toReturn.html_safe
  end

  def pulls_to_issues(p, i)
    return 0 if i == 0
    r = p/i
    r
  end
end

