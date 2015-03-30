class Repository < ActiveRecord::Base
  require 'GithubFacade'
  require 'Analytics'
  # Define accessors so we can access instance (@) variables with a dot.
  attr_reader :repo, :contributors, :primary_lang, :pulls, :read, :languages,
    :relativePopularity, :growthRate

  def self.get(user, repo_name)
    repo = Repository.find_by user: user, name: repo_name
    puts 'making banana pancakes'

    # We can change the caching logic here
    if not repo
      self.refresh user, repo
    end

    @contributors = repo.contributors
    @followers = repo.followers
    @languages = repo.languages # map {string -> integer}
    @primary_lang = repo.primary_lang # map {string -> integer}
    @pulls = repo.pulls
    @read = repo.read_me
    @age = repo.age
    @relativePopularity = repo.popularity
    @hotness = repo.hotness
    @growth = repo.growth
    @stargazers = repo.stargazers
    return self
  end

  def refresh(user, repo_name)
    GithubFacade.initialize
    # Pull all data from APIs into the database
    repo = Repository.new
    repo.name = repo_name
    repo.user = user
    repo.contributors = GithubFacade.getContributors user, repo_name
    repo.languages = GithubFacade.getLanguages user, repo_name
    repo.pulls = GithubFacade.getPulls user, repo_name
    repo.read_me = GithubFacade.getReadMe user, repo_name
    repo.stargazers = GithubFacade.getStars user, repo_name
    repo_list = GithubFacade.getRepos user
    repo.popularity = Analytics.relativePopularity(repo_list, repo.info.stargazers)
    repo.growth = Analytics.growthRate(repo)
  end
end
