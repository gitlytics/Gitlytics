class Repository
  require 'GithubFacade'
  require 'Analytics'
  # Define accessors so we can access instance (@) variables with a dot.
  attr_reader :repo, :contributors, :languages, :pulls, :read,
    :relativePopularity, :growthRate

  GithubFacade.initialize

  def initialize()
  end

  def get(user, repo)
    # TODO: Get Repository with all info, pull from db if applicable, otherwise refresh
    refresh(user, repo)
  end

  def refresh(user, repo)
    # Pull all data from APIs
    @repo = GithubFacade.get user, repo
    @contributors = GithubFacade.getContributors user, repo
    @languages = GithubFacade.getLanguages user, repo
    @pulls = GithubFacade.getPulls user, repo
    @read = GithubFacade.getReadMe user, repo
    # TODO: How badly do we want this? This one takes so long
    repoList = GithubFacade.getRepos user
    @relativePopularity = Analytics.relativePopularity(repoList, @repo.stargazers_count)
    @growthRate = Analytics.growthRate(@repo)
  end

end
