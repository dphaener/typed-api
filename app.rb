require "rubygems"
require "bundler/setup"

require "sinatra/base"

require_relative "system/container"

TypedAPI.boot!(:persistence)
TypedAPI.boot!(:graph)

class App < Sinatra::Base
  use Rack::Deflater

  get "/docs" do
    send_file "./app/views/docs.html"
  end

  post "/graphql" do
    payload = JSON.parse(request.body.read)
    result = TypedAPI["graph.query"].(
      schema: TypedAPI["graph.schema"],
      query: payload["query"],
      variables: payload["variables"],
      context: {
        db: TypedAPI["persistence.db"]
      }
    )
    result.to_json
  end
end
