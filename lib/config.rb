require 'yaml'
require 'erb'

class Config
  class << self
    attr_reader :migration_path, :db_setting_path
    def init
      @migration_path = 'db/migrate'
      @db_setting_path = 'config/database.yml'
    end
  end
end
Config.init
