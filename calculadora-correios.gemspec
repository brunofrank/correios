# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{calculadora-correios}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bruno Frank"]
  s.date = %q{2011-05-28}
  s.description = %q{Calcula o valor do frete dos correios}
  s.email = %q{bfscordeiro@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "README", "README.rdoc", "lib/calculadora-correios.rb"]
  s.files = ["CHANGELOG", "README", "README.rdoc", "Rakefile", "init.rb", "lib/calculadora-correios.rb", "Manifest", "calculadora-correios.gemspec"]
  s.homepage = %q{https://github.com/brunofrank/Calculadora-Correios}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Calculadora-correios"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{calculadora-correios}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Calcula o valor do frete dos correios}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<xml-simple>, [">= 0"])
    else
      s.add_dependency(%q<xml-simple>, [">= 0"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 0"])
  end
end
