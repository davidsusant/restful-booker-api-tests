# Rakefile
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = [
    "features", 
    "--format", "pretty", "--color"
  ]
end

task default: :features
