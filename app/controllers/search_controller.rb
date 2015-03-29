class SearchController < ApplicationController
  require 'GithubClient'
  GithubClient.initialize

  def query
    # Upon form submission, redirect to clean url
    redirect_to "/#{params[:user]}/#{params[:repo]}"
  end

  def index
    # Create analytics page
    # Only redirect if get repo call fails.  If others fail, let it fail so we can troubleshoot.
    begin
      # Check for errors in case repo doesn't exist
      @repo = GithubClient.get params[:user], params[:repo]
    rescue
      # If error -> redirect to error page w/ relevant info, end fn w/ return
      puts "Repo not found"
      redirect_to :controller => 'errors', :action => 'bad_repo', :user => params[:user], :repo => params[:repo]
      return
    end
      @contrib = GithubClient.getContrib params[:user], params[:repo]
      @languages = GithubClient.getLanguages params[:user], params[:repo]
      @pulls = GithubClient.getPulls params[:user], params[:repo]
      @read = GithubClient.getReadMe params[:user], params[:repo]
      @repoList = GithubClient.getRepos params[:user]
  end


end
