class GithubFacade

  def initialize
    @github = Github.new(oauth_token: ENV['GH_TOKEN'])
  end

  def get(user, repo)
    # Get basic repo info
    return @github.repos.get user: user, repo: repo
  end
  
  def getLanguages(user, repo)
    # Get simple language info
    return @github.repos.languages user: user, repo: repo
  end
  
  def getContributors(user, repo)
	#Get number of contributors
	contrib = @github.repos.contributors user: user, repo: repo
	s = contrib.to_s
	value = s.scan("followers_url").length
	return value
  end

  def getPulls(user, repo)
    # Get all pull requests to repo (open and closed)
    state = "all"
    pulls = @github.pull_requests.list user: user, repo: repo, state: state
    return pulls
  end
  
  def getReadMe(user, repo)
	#check if there is a readme file
	begin 
	  read = @github.repos.contents.readme user: user, repo: repo
	  if (read)
	     return true
      end
	rescue
	  return false
	end
  end 

  def getRepos(user)
    #gets list of all the repositories (limit is 100 pages)
	repoList = @github.repos.list user: user, per_page: 100
	return repoList
  end

  def getIssues(user, repo)
    return @github.issues.list user: user, repo: repo
  end
  
end
