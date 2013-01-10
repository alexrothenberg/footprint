$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "schema/models")
MIGRATIONS = File.join(File.dirname(__FILE__), "schema/migrations")
$LOAD_PATH.unshift(MODELS)

require 'footprint'
require 'support/active_record'

# Autoload every model for the test suite that sits in spec/app/models.
Dir[ File.join(MODELS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  
  #Setup SQLite3 DB and run artifacts
  Dir.mkdir("db") unless File.directory?("db")
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "db/fpdb"
  ActiveRecord::Migrator.migrate(MIGRATIONS)
end
