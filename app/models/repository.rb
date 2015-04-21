class Repository < ActiveRecord::Base
  validates :user, :repo_name, :refreshed, :pulls_merged,
    :contributors, :pulls_to_issues, :readme, :popularity, :growth_rate,
    :lang, :stars, :created, presence: true
  store_accessor :languages

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
    #if repo.refreshed < Time.now - (60*60*24*3)
      refresh(repo)
    #end
    repo
  end

  # Pull all data from APIs
  def self.refresh(repo)
    user = repo.user
    repo_name = repo.repo_name
    GithubFacade.initialize
    fac = GithubFacade.get(user, repo_name)
    repo.created = fac.created_at
    repo.stars = fac.stargazers_count
    repo.contributors = GithubFacade.getContributors(user, repo_name)
    repo.languages = GithubFacade.getLanguages(user, repo_name)
    pulls = GithubFacade.getPulls(user, repo_name)
    repo.pulls_merged = Analytics.percentagePullsMerged(pulls)
    issues = GithubFacade.getIssues(user, repo_name)
    repo.pulls_to_issues= Analytics.pullsToIssuesRatio(pulls, issues)
    repo.readme = GithubFacade.getReadMe(user, repo_name)
    repo_list = GithubFacade.getRepos(user)
    repo.popularity = Analytics.relativePopularity(repo_list, fac.stargazers_count)
    repo.growth_rate = Analytics.growthRate(repo.created, repo.stars)
    repo.save
  end

end
