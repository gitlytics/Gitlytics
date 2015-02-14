class SearchController < ApplicationController
  def index
    @repo = Github.repos.get user: params[:user], repo: params[:repo]
  end

end
