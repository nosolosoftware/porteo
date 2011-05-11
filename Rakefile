# encoding: utf-8
require 'rubygems'
require 'rake'

require 'yard'
YARD::Rake::YardocTask.new('doc') do |t|
  t.files = ['lib/runnable.rb', 'lib/runnable/command_parser.rb', 'lib/runnable/gnu.rb', 'lib/runnable/extended.rb']
  t.options = ['-m','markdown', '-r' , 'README.markdown' , '--tag', 'fire:"Publisher events"', '--list-undoc']
end 

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ["./features"] 
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = ["--format doc", "--color"]
end

