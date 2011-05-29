require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('calculadora-correios', '0.1.0') do |p|
  p.description    = "Calcula o valor do frete dos correios"
  p.url            = "https://github.com/brunofrank/Calculadora-Correios"
  p.author         = "Bruno Frank"
  p.email          = "bfscordeiro@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ['xml-simple']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }