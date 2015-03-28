class SearchController < ApplicationController
  require 'GithubClient'
  GithubClient.initialize

  def query
    # Upon form submission, redirect to clean url
    redirect_to "/#{params[:user]}/#{params[:repo]}"
  end

  def index
    # Create analytics page
    begin
      # Check for errors in case repo doesn't exist
      @repo = GithubClient.get params[:user], params[:repo]
      @contrib = GithubClient.getContrib params[:user], params[:repo]
      @languages = GithubClient.getLanguages params[:user], params[:repo]
      @pulls = GithubClient.getPulls params[:user], params[:repo]
      @read = GithubClient.getReadMe params[:user], params[:repo]
      @repoList = GithubClient.getRepos params[:user]
    rescue
      # If error -> redirect to error page w/ relevant info
      puts "Repo not found"
      redirect_to :controller => 'errors', :action => 'bad_repo', :user => params[:user], :repo => params[:repo]
    end
  end


end
