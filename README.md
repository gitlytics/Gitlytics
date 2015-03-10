# Gitlytics

# First use
Replace ```GH_USERNAME``` and ```GH_PASSWORD``` with your username and password 

<b> NEVER PUSH THESE TO GITHUB </b>

# Run it
```bin/rails server```

# Best Practices
### CSS Styles
Do not edit the global css file ```app/assets/stylesheets/application.css```, instead
edit the scss file ```application.scss``` which is in the same directory and compile
to css

### Global HTML header
The code in ```app/views/layouts/application.html.erb``` is applied to each HTML
page globally. So things like the page titles, bootstrap include, and global font are here.

