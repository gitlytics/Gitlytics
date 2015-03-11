# Gitlytics

# To use locally
For running locally, the GithubClient model searches for two environment variables so that we don’t have to define them in the code.

These are GH_USERNAME and GH_PASSWORD.  To set, in the same terminal you will run the server from, type (with the quotes): 

```
export GH_USERNAME=’username’
export GH_PASSWORD=’password’
```

Test out by using
``` echo $GH_USERNAME ```

You can also add these to your .bashrc and .bash_profile files, but I’m not sure how secure this is.

# Run it
```bin/rails server```

# Best Practices
### CSS Styles
The CSS styling is handled in ```app/assets/stylesheets/```, but do not edit the global css file ```application.css```. Instead edit the scss file ```application.scss``` which is in the same directory and compile by running ```./compileCSS.sh```. This is scss sytax, which is like css but includes variable names and several other useful css improvements. [Teach me how to scss](http://sass-lang.com/guide).

### Global HTML header
The code in ```app/views/layouts/application.html.erb``` is applied to each HTML
page globally. So things like the page titles, bootstrap include, and global font are here only once and therefore do not need to be included in any other html files.

