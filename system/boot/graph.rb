require_relative "../graph/container"

TypedAPI.finalize(:graph) do |graph|
  start do
    graph.register("graph", Graph::Container)
    graph.register("graph.query", Graph::Container["query"])
    graph.register("graph.schema", Graph::Container["schema"])
  end
end
