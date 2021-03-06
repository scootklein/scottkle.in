
require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

# add a route for blog
module Toto
  class Site
    def blog type = :html
      articles = type == :html ? self.articles.reverse : self.articles
      {:articles => articles.map do |article|
        Article.new article, @config
      end}.merge archives
    end
  end
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :author,    ENV['USER']                               # blog author
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :author,      'Scott Klein'
  set :title,       'scootklein'
  set :url,         'http://www.scottkle.in'
  set :disqus,      'scottkleinblog'                          
  set :cache,       0                                         # turn off caching for now
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

run toto


