class SearchController < ApplicationController
  require 'Repository'

  def query
    # Upon form submission, redirect to clean url
    redirect_to "/#{params[:user]}/#{params[:repo]}"
  end

  def index
    # Create analytics page
    begin
      # Check for errors in case repo doesn't exist
      @repository = Repository.new
      @repository.get(params[:user], params[:repo])
    rescue Exception => e  
      puts e.message  
      # If error -> redirect to error page w/ relevant info, end fn w/ return
      puts "Repo not found"
      redirect_to :controller => 'errors', :action => 'bad_repo', :user => params[:user], :repo => params[:repo]
      return
    end
  end

end
