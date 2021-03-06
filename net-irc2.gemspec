$LOAD_PATH.unshift "lib"

require 'rubygems' unless defined?(Gem)
require_relative 'lib/net/irc'

Gem::Specification.new do |s|
  s.name              = "net-irc2"
  s.version           = Net::IRC::VERSION.dup
  s.platform          = Gem::Platform::RUBY
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "ChangeLog"]
  s.rdoc_options      = [
    '--exclude', '^(examples|extras)/',
    '--title', "net-irc documentation",
    "--charset", "utf-8",
    "--opname", "index.html",
    "--line-numbers",
    "--main", "README",
    "--inline-source"
  ]
  s.summary           = "library for implementing IRC server and client"
  s.description       = "library for implementing IRC server and client"
  s.author            = "Marcin Labanowski"
  s.email             = "marcin@6irc.net"
  s.homepage          = "https://github.com/czaks/net-irc2/"
  s.executables       = %w()
  s.bindir            = "bin"
  s.require_path      = "lib"

  s.files = %w(README ChangeLog Rakefile AUTHORS.txt) +
    Dir.glob("{bin,doc,spec,test,lib,templates,generator,extras,website,script}/**/*") +
    Dir.glob("ext/**/*.{h,c,rb}") +
    Dir.glob("examples/**/*.rb") +
    Dir.glob("tools/*.rb")

  s.add_dependency 'buftok'

  s.add_development_dependency 'shipit'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'thor'
end
