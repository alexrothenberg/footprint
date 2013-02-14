require "bundler/gem_tasks"
require 'active_record'
require 'logger'
require 'rspec/core/rake_task'

task :default => :spec
RSpec::Core::RakeTask.new

namespace :db do
  desc "Migrate the database through scripts in spec/schema/migrations"
  task :prepare => :environment do
    ActiveRecord::Migration.verbose = true
    
    MIGRATIONS = File.join(File.dirname(__FILE__), "spec/schema/migrations")
    ActiveRecord::Migrator.migrate(MIGRATIONS)
  end

  task :environment do
    Dir.mkdir("db") unless File.exist?("db")
    File.delete('db/fpdb') if File.exist?('db/fpdb')
    
    ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "db/fpdb"
    ActiveRecord::Base.logger = Logger.new(File.open('db/database.log', 'a')) 
  end
end

namespace :generate do
  desc "generate a fresh app with rspec installed"
  task :app do |t|
    unless File.directory?('./tmp/example_app')
      sh "rails new ./tmp/example_app --skip-javascript --skip-gemfile --skip-git"
      bindir = File.expand_path("bin")
      if test ?d, bindir
        Dir.chdir("./tmp/example_app") do
          sh "rm -rf test"
          sh "ln -s #{bindir}"
          application_file = File.read("config/application.rb")
          sh "rm config/application.rb"
          File.open("config/application.rb","w") do |f|
            f.write application_file.gsub("config.assets.enabled = true","config.assets.enabled = false")
          end
        end
      end
    end
  end
end

task :rspec => 'generate:app'
