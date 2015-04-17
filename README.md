# Getbox

## Installation

Install as a gem:

    gem install gembox

## Usage

The gem installs a global `gembox` executable, which will guide you through exporting your gists. Sometimes it takes a minute.

## API

### method to enter an interactive prompt and save gists to a file as JSON:

Getbox::prompt

### methods to return an array of gists:

Getbox::getGistsFromSite(username, password)

Getbox::getGistsFromFile(location_of_html_file)

Getbox::getGistsFromHtml(html_string)
