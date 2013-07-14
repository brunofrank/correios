# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "correios/version"

Gem::Specification.new do |s|
  s.name        = "correios"
  s.version     = Correios::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bruno Frank"]
  s.email       = ["bfscordeiro@gmail.com"]
  s.homepage    = "https://github.com/brunofrank/correios"
  s.summary     = %q{Calcula o valor do frete dos Correios.}
  s.description = %q{Gem para calculo de valor e restreamento dos Correios.}
  s.add_dependency("xml-simple")
  s.add_dependency("nokogiri")
  s.add_development_dependency("mocha")

  s.rubyforge_project = "correios"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license = 'MIT'
end
