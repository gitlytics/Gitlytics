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
  
  def getTime(repoTime, curTime)
	repYear = repoTime[0..3].to_i
	repMonth = repoTime[5..6].to_i
	repDay = repoTime[8..9].to_i
	curYear = curTime[0..3].to_i
	curMonth = curTime[5..6].to_i
	curDay = curTime[8..9].to_i
	year = curYear - repYear
	puts year
	month = curMonth - repMonth
	puts month
	day = curDay - repDay
	if (day < 1)
	  day = 1
	end
	return (year*360 + month*30 + day)
  end
  
  #def getList(user,repoList)
     #repoList = repoList.to_s
     #subStr1 = "git_commit_url"
     #subStr2 = "full_name=" + user + "/"
     #return repoList[/#{subStr2}()#{subStr1}/m, 1]
  #end
end

