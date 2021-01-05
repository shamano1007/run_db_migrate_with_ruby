# NOTE: 参考
# https://www.rubydoc.info/github/wycats/thor/Thor.register
# https://qiita.com/tbpgr/items/471e4c1989cde60cc5e8
require 'thor'
require 'time'

class Generator < Thor::Group
  include Thor::Actions
  argument :target
  argument :name
  argument :class_name, required: false
  argument :migration_class_name, required: false
  argument :table_name, required: false
  attr_reader :file_name, :time

  class << self
    def source_root
      File.dirname(__FILE__)
    end
  end

  # WARNING: 実行method以外はprivateにしておく
  #          上から順位method実行されるみたい
  def valid!
    return if %i[model migration].include?(target.to_sym)

    puts 'error: 第一引数は「migration」or「model」にしてください'
    exit
  end

  def init
    @class_name = @migration_class_name = name.camelize
    @table_name = name
    @file_name = name
    ENV['TZ'] = 'Asia/Tokyo'
    @time = Time.now.strftime('%Y%m%d%H%M%S')
  end

  def create
    # TODO: ファイルの重複チェック
    send("generate_#{target}")
  end

  private

  def generate_model
    template(
      'templates/model.rb.tt',
      "#{Config.model_path}/#{file_name}.rb"
    )
    template(
      'templates/create_table_migration.rb.tt',
      "#{Config.migration_path}/#{time}_create_#{file_name}.rb"
    )
  end

  def generate_migration
    template(
      'templates/migration.rb.tt',
      "#{Config.migration_path}/#{time}_#{file_name}.rb"
    )
  end
end

module GeneratorUtil
  class CLI < Thor
    register(Generator, 'generate', 'g', 'generateコマンド')

    def self.exit_on_failure?
      true
    end
  end
end
