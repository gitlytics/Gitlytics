class Repository < ActiveRecord::Base
  # Define accessors so we can access instance (@) variables with a dot.
  attr_reader :stargazers, :growth_rate, :languages, :age, :created, :readme,
    :percentagePullsMerged, :pullsToIssuesRatio, :popularity, :contributors, :lang

  def initialize
    GithubFacade.initialize
  end

  def get(user, repo)
    # TODO: Get Repository with all info, pull from db if applicable, otherwise refresh
    if true
      refresh(user, repo)
    end
    puts @languages
    @lang = 'hi'
  end

  def refresh(user, repo)
    # Pull all data from APIs
    @repo = GithubFacade.get user, repo
    @contributors = GithubFacade.getContributors user, repo
    @languages = GithubFacade.getLanguages user, repo
    pulls = GithubFacade.getPulls user, repo
    @percentagePullsMerged = Analytics.percentagePullsMerged pulls
    issues = GithubFacade.getIssues user, repo
    @pullsToIssuesRatio = Analytics.pullsToIssuesRatio pulls, issues
    @read = GithubFacade.getReadMe user, repo
    # TODO: How badly do we want this? This one takes so long
    repoList = GithubFacade.getRepos user
    @relativePopularity = Analytics.relativePopularity(repoList, @repo.stargazers_count)
    @growthRate = Analytics.growthRate(@repo)
  end

end
