ENV['ENV'] ||= 'development'

require 'active_record'
require './lib/config'

Dir['lib/tasks/*'].each { |file| load(file) }
