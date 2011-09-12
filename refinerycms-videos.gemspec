$:.push File.expand_path("../lib", __FILE__)

require "refinery/videos/version"

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = "refinerycms-videos"
  s.version       = Refinery::Videos::Version.to_s
  s.authors       = ["Jamie Winsor"]
  s.email         = ["jamie@enmasse.com"]
  s.homepage      = "https://github.com/enmasse-entertainment/refinerycms-videos"
  s.summary       = 'Videos engine for Refinery CMS'
  s.description   = 'Ruby on Rails Videos engine for Refinery CMS'
  s.require_paths = %w(lib)

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'refinerycms-core', '~> 2.0.0'
  s.add_dependency 'dragonfly-ffmpeg', '~> 0.0.4'
  s.add_dependency 'resque', '~> 1.17.1'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "refinerycms-testing", '~> 2.0.0'
end
