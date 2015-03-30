# Gitlytics

# To use locally
For running locally, the GithubClient model searches for two environment variables so that we don’t have to define them in the code.

These are GH_USERNAME and GH_PASSWORD.  To set, in the same terminal you will run the server from, type (with the quotes): 

```
export GH_USERNAME='username'
export GH_PASSWORD='password'
```

Test out by using
``` echo $GH_USERNAME ```

Add these to your .bashrc for persistance

# Run it
```bin/rails server```

# Database
If we want to use Heroku for hosting, we should ensure not to use SQLite and rather use PostgreSQL (https://devcenter.heroku.com/articles/sqlite3).  The alternative is to set up an ec2 or digitial ocean instance and handle the DB creation, etc. on our own.

Add the following line to /etc/postgresql/9.4/main/pg_hba.conf:
local   all gitlytics   md5

restart postgres:
sudo service postgresql restart

rake db:create

# Best Practices
### CSS Styles
The CSS styling is handled in ```app/assets/stylesheets/```, but do not edit the global css file ```application.css```. Instead edit the scss file ```application.scss``` which is in the same directory and compile by running ```./compileCSS.sh```. This is scss sytax, which is like css but includes variable names and several other useful css improvements. [Teach me how to scss](http://sass-lang.com/guide).

### Global HTML header
The code in ```app/views/layouts/application.html.erb``` is applied to each HTML
page globally. So things like the page titles, bootstrap include, and global font are here only once and therefore do not need to be included in any other html files.

### Image minification
If you add even a single image to the repo, perform a lossless minification with ```optipng filename```. This saves on our total repo size without sacrificing quality
