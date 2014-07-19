require 'rubygems'
require 'bundler/gem_tasks'
require 'bundler/setup'
Bundler.setup(:development)

require 'shipit'
require 'rake'
require 'rake/clean'
require 'rake/contrib/sshpublisher'
require 'rdoc/task'
require 'fileutils'

require 'rspec/core/rake_task'

include FileUtils

$LOAD_PATH.unshift "lib"
require "net/irc"

GEMSPEC = Gem.latest_spec_for('net-irc2')

CLEAN.include ['**/.*.sw?', '*.gem', '.config']

task :default => [:spec]
task :package => [:clean]

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--options', "spec/spec.opts"]
end 

task :upload_doc => [:rdoc] do
  sh %{rsync --update -avptr html/ lowreal@cho45.stfuawsc.com:/virtual/lowreal/public_html/cho45.stfuawsc.com/net-irc}
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'html'
  rdoc.options += GEMSPEC.rdoc_options
  rdoc.template = "resh"
  if ENV['DOC_FILES']
    rdoc.rdoc_files.include(ENV['DOC_FILES'].split(/,\s*/))
  else
    rdoc.rdoc_files.include('README', 'ChangeLog')
    rdoc.rdoc_files.include('lib/**/*.rb')
    rdoc.rdoc_files.include('ext/**/*.c')
  end
end

Rake::ShipitTask.new do |s|
  s.ChangeVersion "lib/net/irc.rb", "VERSION"
  s.Commit
  s.Task :clean, :package, :upload_doc
  s.Step.new {
  }.and {
    system("gem", "push", "pkg/net-irc2-#{GEMSPEC.version}.gem")
  }
  s.Tag
  s.Twitter
end

task 'AUTHORS.txt' do
  File.open('AUTHORS.txt', 'w') do |f|
    f.puts "Core Authors::"
    f.puts `git shortlog -s -n lib`.gsub(/^\s*\d+\s*/, '')
    f.puts
    f.puts "Example Contributors::"
    f.puts `git shortlog -s -n examples`.gsub(/^\s*\d+\s*/, '')
  end
end

