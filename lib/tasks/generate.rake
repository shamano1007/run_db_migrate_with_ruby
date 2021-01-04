# require 'rails/generators/active_record/migration/migration_generator'
require 'rails/generators/active_record/migration'
# activerecord/lib/rails/generators/active_record/migration.rb
# activerecord/lib/rails/generators/active_record.rb
# require "active_record/rails/generators/active_record/migration/migration_generator"
# activerecord/lib/rails/generators/active_record/migration/migration_generator.rb
namespace :g do
  desc 'create migration'
  task :migration do
    on_skip = Proc.new do |name, migration|
      puts "NOTE: Migration #{migration.basename} from #{name} has been skipped. Migration with the same name already exists."
    end

    on_copy = Proc.new do |name, migration|
      puts "Copied migration #{migration.basename} from #{name}"
    end

    ActiveRecord::Migration.copy('db/migrate', railties, on_skip: on_skip, on_copy: on_copy)
  end
end
# source = File.expand_path(find_in_source_paths(source.to_s))
