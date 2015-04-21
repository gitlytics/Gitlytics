class Analytics
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
      return "This repository has fewer stars than some other repository with maximum star count of " + maxStars.to_s
    elsif numStars >= maxStars
      return "This repository has the most stars compared to other repos by the same user."
    end
  end

  def self.growthRate(created, stars)
    t = Time.now - created
    stars/t
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

    percentageMerged = merged.to_f/total
    return percentageMerged
  end

  def self.pullsToIssuesRatio(pulls, issues)
    # Calculate ratio of pulls : issues
    numPulls = pulls.length
    numIssues = issues.length

    ratio = numPulls.to_f / numIssues
    return ratio
  end

end
