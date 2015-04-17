# Getbox

## Installation

Install as a gem:

    gem install gembox

## Usage

The gem installs a global `gembox` executable, which will guide you through exporting your gists. Sometimes it takes a minute.

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

### method to enter an interactive prompt and save gists to a file as JSON:

Getbox::prompt

### methods to return an array of gists:

Getbox::getGistsFromSite(username, password)

Getbox::getGistsFromFile(location_of_html_file)

Getbox::getGistsFromHtml(html_string)
