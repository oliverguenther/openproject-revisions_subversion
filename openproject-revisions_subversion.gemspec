# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/revisions/subversion/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-revisions_subversion"
  s.version     = OpenProject::Revisions::Subversion::VERSION
  s.authors     = ["Oliver Günther"]
  s.email       = "mail@oliverguenther.de"
  s.homepage    = "https://www.github.com/oliverguenther/openproject-revisions_subversion"
  s.summary     = 'Revisions/Subversion'
  s.description = "This plugin creates subversion repositories through svnadmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*"] + %w(README.md)

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "openproject-revisions"

end
