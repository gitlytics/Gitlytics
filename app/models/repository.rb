class Repository < ActiveRecord::Base
  validates :user, :repo_name, :refreshed, :pulls_merged,
    :contributors, :issues, :readme, :popularity, :growth_rate,
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
    if repo.refreshed < Time.now - (60*60*24*3)
      refresh(repo)
    end
    repo
  end

  def age
    (Time.now - self.created)/(60*60*24)
  end

  # Pull all data from APIs
  def self.refresh(repo)
    user = repo.user
    repo_name = repo.repo_name

    fac = GithubFacade.new
    remote = fac.get(user, repo_name)

    repo.created = remote.created_at
    repo.stars = remote.stargazers_count
    repo.contributors = fac.getContributors(user, repo_name)
    repo.languages = fac.getLanguages(user, repo_name).to_hash
    repo.lang = remote.language.to_s
    pulls = fac.getPulls(user, repo_name)
    repo.pulls_merged = Analytics.percentagePullsMerged(pulls)
    repo.issues = fac.getIssues(user, repo_name).length
    repo.readme = fac.getReadMe(user, repo_name)
    repo_list = fac.getRepos(user)
    repo.popularity = Analytics.relativePopularity(repo_list, remote.stargazers_count)
    repo.growth_rate = Analytics.growthRate(repo.created, repo.stars)
    repo.refreshed = Time.now
    repo.save!
  end
end
