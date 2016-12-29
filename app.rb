require "rubygems"
require "bundler/setup"

require "sinatra/base"
require "dotenv"

Dotenv.load

class App < Sinatra::Base
  enable :sessions, :protection
  set :session_secret, ENV.fetch("SECRET")

  use Rack::Deflater

  post "/graphql" do

  end
end
