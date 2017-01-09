require "rom/sql/rake_task"

namespace :db do
  task :setup do
    require_relative "#{Dir.pwd}/system/container"

    TypedAPI.boot!(:persistence)
    TypedAPI["persistence.db"]
  end
end
