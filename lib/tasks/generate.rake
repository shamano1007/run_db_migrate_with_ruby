require './lib/generators/generator'

desc 'generator'
task :generate do
  add_dummy_task(ARGV.drop(1))

  GeneratorUtil::CLI.start(ARGV)
end
desc 'generator'
task g: ['generate']

# generateタスクの引数をスペースで渡すために設定
def add_dummy_task(tasks)
  tasks.each do |t|
    task t, [*Rake.application['nil'].arg_names] => ['nil']
  end
end
task :nil do; end
