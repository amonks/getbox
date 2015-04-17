require 'getbox/version'
require 'nokogiri'          # for parsing html
require 'capybara/dsl'      # to operate the headless browser
require 'capybara-webkit'   # the headless browser
require 'json'              # for pretty json output

module Getbox

  # configure Capybara
  include Capybara::DSL
  Capybara.default_driver = :webkit
  Capybara.app_host =  "http://app.gistboxapp.com"
  Capybara.run_server = false

  # to use getbox interactively and write output to a file
  def prompt()
    # people shouldn't feel comfortable typing passwords into things.
    puts \
      "I'm about to ask for your github password. \n"\
      "You should probably read my source code\n"\
      "before you go through with this...\n"\
      "https://github.com/amonks/getbox/blob/master/lib/getbox.rb\n\n"\
      \
      "are you sure you want to continue?"

    raise "Well, OK then." if gets.chomp.downcase.include? "no"

    puts "What's your github username?"
    username = gets.chomp
    puts "How about your password, eh??"
    password = gets.chomp

    # doesn't support anything cool like ~, only a locally relative path
    puts "Where should I save your gists? [gists.json]"
    file = gets.chomp
    file = "gists.json" if file.empty?

    gists = getGistsFromSite(username, password)

    puts "Saving #{gists.length} gists to #{Dir.pwd}/#{file}"
    writeToFile(gists, file)
  end

  # method to go to app.gistboxapp.com, and log in with github credentials
  def getGistsFromSite(username, password)
    # partly to avoid warnings, and partly to avoid hitting analytics
    whitelist_urls

    puts "visiting app.gistboxapp.com"
    visit '/'
    click_on "Login"      # redirect to github login page

    puts "filling out github login form"
    within("#login") do
      fill_in("login", :with => username)
      fill_in("password", :with => password)
      click_on "Sign in"  # back to gistbox.app
    end

    puts "gathering gists"
    getGistsFromHtml(page.html)
  end

  # convenience wrapper for file.open.
  # saving gistbox's dashboard html in chrome is faster than fetching it in ruby.
  def getGistsFromFile(file)
    f = File.open(file)
    getGistsFromHtml(f)
  end

  # main function to parse the gist data from gistbox's interface
  def getGistsFromHtml(html)
    doc = Nokogiri::HTML(html)

    gists = []

    doc.css('div.split-gist').each do |gist|
      data = {}

      id = gist.attribute('data-id').value
      data[:url] = "https://gist.github.com/#{id}"

      data[:title] = gist.css('div.gist-name').inner_text

      data[:timestamp] = gist.css('span.gist-created-updated').inner_text

      description = gist.css('div.gist-description').inner_text.strip
      description = nil if description == 'No Description'
      data[:description] = description if description

      labels = []
      gist.css('span.gist-label').each {|label| labels.push label.inner_text}
      data[:labels] = labels

      gists.push data
    end

    gists
  end

  # convenience wrapper for json-and-print
  def writeToFile(object, file)
    json = JSON.pretty_generate(object)
    File.open(file, 'w') { |f| f.write(json) }
  end

  # set up capybara-webkit's whitelest
  def whitelist_urls()
    page.driver.block_unknown_urls  # block tracking and media, disable warnings
    urls = [
      'app.gistboxapp.com',         # whitelist the servers we need
      'github.com',
    ]
    urls.each { |url| page.driver.allow_url(url) }
  end
end
