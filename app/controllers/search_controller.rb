class SearchController < ApplicationController
  require 'GithubClient'

  def query
    # Upon form submission redirect to clean url
    redirect_to "/#{params[:user]}/#{params[:repo]}"
  end

  def index
    # Create analytics page
    GithubClient.initialize

    @repo = GithubClient.get params[:user], params[:repo]
    @languages = GithubClient.getLanguages params[:user], params[:repo]
    @pulls = GithubClient.getPulls params[:user], params[:repo]
  end


end
