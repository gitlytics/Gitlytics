class Repository < ActiveRecord::Base
  serialize :repo, Hash

  def self.get(user, repo_name)
    # make a new repo if it doesn't exist
    repo = Repository.where(user: user, repo_name: repo_name)[0]
    if not repo
      repo = Repository.new
      repo.user = user
      repo.repo_name = repo_name
      repo.refreshed = Time.at(0)
    end

    # refresh the repo if it has been more than 3 days
    if repo.refreshed < Time.now - (60*60*24*3)
      refresh(repo)
    end
  end

  # Pull all data from APIs
  def refresh(repo)
    GithubFacade.initialize
    fac = GithubFacade.get user, repo_name
    repo.stargazers = fac.stargazers_count
    repo.contributors = GithubFacade.getContributors user, repo_name
    repo.languages = GithubFacade.getLanguages user, repo_name
    pulls = GithubFacade.getPulls user, repo_name
    repo.percentage_pulls_merged = Analytics.percentagePullsMerged pulls
    issues = GithubFacade.getIssues user, repo_name
    repo.pulls_to_issues= Analytics.pullsToIssuesRatio pulls, issues
    repo.readme = GithubFacade.getReadMe user, repo_name
    repo.popularity = Analytics.relativePopularity(repoList, fac.stargazers_count)
    repo.growth_rate = Analytics.growthRate(fac)
    repo.save
  end

end
