# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$ ->
    console.log('Dom Ready')
    $('#user').change ->
        # We are in the repo field and need autocomplete
        username = $(this).val()
        repos = []
        callback = (response) -> 
            # Only gets first 30 for now
            repos.push(response[i].name) for i in [0 .. response.length-1]
            $( "#repo" ).autocomplete(
                {
                      source: repos
                }
            )
            
        $.get 'https://api.github.com/users/' + username + '/repos?per_page=1000', {username}, callback, 'json'

