class SearchController < ApplicationController
  require 'GithubClient'
  
  def index
    GithubClient.initialize
    
    @repo = GithubClient.get params[:user], params[:repo]#Github.repos.get user: params[:user], repo: params[:repo]
    @languages = GithubClient.getLanguages params[:user], params[:repo] #github.repos.languages user: params[:user], repo: params[:repo]
    @pulls = GithubClient.getPulls params[:user], params[:repo]
  end

end
