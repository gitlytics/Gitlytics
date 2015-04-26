class SearchController < ApplicationController
  def query
    # Upon form submission, redirect to clean url
    if (params[:user].length > 0 and params[:repo].length > 0)
       redirect_to "/#{params[:user]}/#{params[:repo]}"
	else
	   redirect_to :controller => 'errors', :action => 'bad_repo', :user => params[:user], :repo => params[:repo]
	end
	
  end

  def index
    # Create analytics page
    begin
      @repo = Repository.get(params[:user], params[:repo])
      if params[:refresh] == 'true'
        Repository.refresh(@repo)
      end
    rescue Github::Error::NotFound => e
      puts e.message
      # If error -> redirect to error page w/ relevant info, end fn w/ return
      redirect_to :controller => 'errors', :action => 'bad_repo', :user => params[:user], :repo => params[:repo]
    end
  end

end
