require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

# just 'rake test'
Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = Dir["test/**/test*.rb"]
end