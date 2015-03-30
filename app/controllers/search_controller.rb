class SearchController < ApplicationController
  def query
    # Upon form submission, redirect to clean url
    redirect_to "/#{params[:user]}/#{params[:repo]}"
  end

  def index
    # Create analytics page
    @repository = Repository.get(params[:user], params[:repo])
  end

end
