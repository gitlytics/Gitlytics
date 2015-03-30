class GithubFacade

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
  
  def self.getContributors(user, repo)
	#Get number of contributors
	contrib = @@github.repos.contributors user: user, repo: repo
	s = contrib.to_s
	value = s.scan("followers_url").length
	return value
  end

  def self.getPulls(user, repo)
    # Get all pull requests to repo (open and closed)
    state = "all"
    pulls = @@github.pull_requests.list user: user, repo: repo, state: state
    return pulls
  end
  
  def self.getReadMe(user, repo)
	#check if there is a readme file
	begin 
	  read = @@github.repos.contents.readme user: user, repo: repo
	  if (read)
	     return "This repository has a README"
	  end
	rescue
	  return "This repository does not have a README"
	end
  end
  
  def self.getRepos(user)
    #gets list of all the repositories (limit is 100 pages)
	repoList = @@github.repos.list user: user, per_page: 100
	return repoList
  end
  
end
