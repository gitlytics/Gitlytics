# TODO: Where should globals go?
USERNAME = ENV['GH_USERNAME']
PASSWORD = ENV['GH_PASSWORD']

class SearchController < ApplicationController
  def index
    github = Github.new basic_auth: "#{USERNAME}:#{PASSWORD}"
    @repo = github.repos.get user: params[:user], repo: params[:repo]
    @languages = github.repos.languages user: params[:user], repo: params[:repo]
    @pulls = getAllPulls github
  
  end
  
  private

  def getAllPulls github
    # I believe this fn should go in the github class
    pulls = Array.new
    counter = 1
    # As far as I can tell, we can't get the # of pulls, so we have to go until we hit one that doesn't exist
    # TODO: Find a nicer way to do this.
    while true do
      # Add error handling for when we hit the last PR
      begin
        pull = github.pull_requests.get user: params[:user], repo: params[:repo], number: counter
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
