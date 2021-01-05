# NOTE: 参考
# activerecord/lib/active_record/railties/databases.rake

require 'yaml'
require 'erb'

namespace :db do
  desc 'Create database'
  task create: :environment do
    ActiveRecord::Tasks::DatabaseTasks.create(database_config)
  end

  desc 'Drop database'
  task drop: :environment do
    ActiveRecord::Tasks::DatabaseTasks.drop(database_config)
  end

  desc "Retrieves the current schema version number"
  task version: :environment do
    puts "Current version: #{ActiveRecord::Base.connection.migration_context.current_version}"
  end

  desc 'Migrate database'
  task migrate: :environment do
    ActiveRecord::Migrator.migrate(Config.migration_path, ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n)'
  task :rollback do
    step = ENV["STEP"] ? ENV["STEP"].to_i : 1
    ActiveRecord::Base.connection.migration_context.rollback(step)
  end

  task :environment do
    db_confs = YAML.load(ERB.new(File.read(Config.db_setting_path)).result)
    ActiveRecord::Base.configurations = db_confs
    # `rake ENV=development`/`rake ENV=production`で切り替え可能
    ActiveRecord::Base.establish_connection(database_config)
    ActiveRecord::Base.logger = Logger.new("log/database.log")
  end

  def database_config
    # NOTE: nameはDB一つを一旦想定しているため `primary` 固定
    ActiveRecord::Base.configurations.configs_for(env_name: ENV['ENV'], name: 'primary')
  end
end
