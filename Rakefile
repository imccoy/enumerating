require "rake"

# require 'bundler'
# Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["--colour", "--format", "nested"]
end

task "default" => "spec"
