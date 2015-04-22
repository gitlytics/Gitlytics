class Analytics
  # Use ostruct so we can reference with dot - I'm lazy
  require 'ostruct'

  def self.relativePopularity(repoList, numStars)
    #gets list of all the repositories (limit is 100 pages)
    maxStars = 0
    repoList.each do |star|
      starCount = star.stargazers_count.to_i
      if starCount > maxStars
        maxStars = starCount
      end
    end
    if maxStars > numStars
      return "<span class=\"fa-stack fa-5x\"><i class=\"fa fa-star fa-stack-1x\"></i><i class=\"fa fa-ban fa-stack-2x text-danger \"></i></span><p>(Not the user's most popular repo)</p>"
    else
      return "<i class=\"fa fa-star fa-5x\"></i><p>(User's most popular repo!)<\p>"
    end
  end

  def self.getTime(repoTime, curTime)
    # Helper function for growthRate
    # TODO: Steven this is cool, but there's got to be a built in function for this, right?
    repYear = repoTime[0..3].to_i
    repMonth = repoTime[5..6].to_i
    repDay = repoTime[8..9].to_i
    curYear = curTime[0..3].to_i
    curMonth = curTime[5..6].to_i
    curDay = curTime[8..9].to_i
    year = curYear - repYear
    month = curMonth - repMonth
    day = curDay - repDay
    if (day < 1)
      day = 1
    end
    return (year*360 + month*30 + day)
  end

  def self.growthRate(repo)
    toReturn = {}
    toReturn[:repoTime] = repo.created_at.sub("T"," ").sub("Z", " ")
    toReturn[:time] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    toReturn[:timeSince] = getTime(toReturn[:repoTime], toReturn[:time]).to_i
    toReturn[:rate] = 1.0/(getTime(toReturn[:repoTime], toReturn[:time]).to_f/repo.stargazers_count.to_f)
    return OpenStruct.new(toReturn)
  end

  def self.percentagePullsMerged(pulls)
    # Calculate percentage of pull requests merged into master
    total = pulls.length
    merged = 0
    for pull in pulls do
      if pull.merged_at
        merged = merged+1
      end
    end

    percentageMerged = merged.to_f*100/total
    return percentageMerged.floor
  end

  def self.pullsToIssuesRatio(pulls, issues)
    # Calculate ratio of pulls : issues
    numPulls = pulls.length
    numIssues = issues.length

    ratio = numPulls.to_f / numIssues
    return ratio
  end

end
