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
    # Get all pull request data for a repo
    # TODO: Find a nicer way to do this.
    pulls = Array.new
    counter = 1
    # As far as I can tell, we can't get the # of pulls, so we have to go until we hit one that doesn't exist
    while true do
      # Add error handling for when we hit the last PR
      begin
        pull = @@github.pull_requests.get user: user, repo: repo, number: counter
      rescue Github::Error::GithubError => e
        puts e
        break
      end
      if pull
        # We'll probably actually want all (or most) of the data here rather than just state
        pull = pull.state
        pulls << pull
        counter += 1
      else
        break
      end
    end
    return pulls
  end
end
