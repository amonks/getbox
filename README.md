# Getbox [![Gem](https://img.shields.io/gem/v/getbox.svg?style=plastic)](https://rubygems.org/gems/getbox)

[GistBox](http://gistboxapp.com) lets you tag/label your GitHub Gists, but it doesn't let you export that label data.

The `getbox` gem installs a global executable, which will guide you through exporting your gists from GistBox.

    $ gem install getbox
    Successfully installed getbox-1.0.3
    1 gem installed
    $ getbox
    I'm about to ask for your github password. 
    You should probably read my source code
    before you go through with this...
    https://github.com/amonks/getbox/blob/master/lib/getbox.rb
    
    are you sure you want to continue?
    $ I sure am!
    What's your github username?
    $ amonks
    How about your password, eh??
    $ [secret]
    Where should I save your gists? [gists.json]
    $ mygists.json
    visiting app.gistboxapp.com
    filling out github login form
    gathering gists
    Saving 46 gists to /Users/amonks/Desktop/mygists.json

## API

You can even use the getbox gem in your own scripts, if you want.

### method to enter an interactive prompt and save gists to a file as JSON:

    Getbox::prompt

### methods to return an array of gists:

    Getbox::getGistsFromSite(username, password)
    
    Getbox::getGistsFromFile(location_of_html_file)
    
    Getbox::getGistsFromHtml(html_string)

The html should be from `https://app.gistboxapp.com/library/my-gists`
