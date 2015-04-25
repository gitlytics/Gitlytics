class Analytics
  def self.relativePopularity(repoList, numStars)
    #gets list of all the repositories (limit is 100 pages)
    greater = 1
    repoList.each do |star|
      stars = star.stargazers_count.to_i
      if stars > numStars
        greater += 1
      end
    end
    greater
  end

  def self.growthRate(created, stars)
    t = (Time.now - created)/(60*60*24)
    puts "growth: " + (stars/t).to_s
    stars/t
  end

  def self.percentagePullsMerged(pulls)
    # Calculate percentage of pull requests merged into master
    total = pulls.length
    return 100 if total == 0
    merged = 0
    pulls.each do |pull|
      if pull.merged_at
        merged += 1
      end
    end
    percent = merged*100 / total

    percent
  end
end
