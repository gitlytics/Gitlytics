class GithubClient

  def self.initialize
    username = ENV['GH_USERNAME']
    password = ENV['GH_PASSWORD']
    # GitHub API library
    @@github = Github.new basic_auth: "#{username}:#{password}"

  end

  def self.get(user, repo)
    # Get basic repo info
    return @@github.repos.get user: user, repo: repo
  end

  def self.getLanguages(user, repo)
    # Get simple language info
    return @@github.repos.languages user: user, repo: repo
  end

  def self.getPulls(user, repo)
    # Get all pull requests to repo (open and closed)
    state = "all"
    pulls = @@github.pull_requests.list user: user, repo: repo, state: state
    return pulls
    
  end
end
