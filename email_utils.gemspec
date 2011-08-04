# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "email_utils/version"

Gem::Specification.new do |s|
  s.name        = "email_utils"
  s.version     = EmailUtils::VERSION
  s.authors     = ["Neil Chandler"]
  s.email       = ["neilc@yourgolftravel.com"]
  s.homepage    = ""
  s.summary     = %q{Useful methods for validating and creating emails}
  s.description = %q{Useful methods for validating and creating emails}

  s.rubyforge_project = "email_utils"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
