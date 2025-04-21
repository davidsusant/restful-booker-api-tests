# Rakefile
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = [
    "features", 
    "--format", "pretty", "--color",
    "--format", "AllureCucumber::CucumberFormatter",
    "--out", "allure-results"
  ]
end

desc "Generate Allure Report"
task :allure_report do
  sh "allure generate allure-results --clean -o allure-report"
  sh "allure open allure-report"
end

task default: :features
