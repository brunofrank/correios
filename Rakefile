require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('correios', '0.5.0') do |p|
  p.description    = "Gem para calculo de valor e restreamento dos correios"
  p.url            = "https://github.com/brunofrank/correios"
  p.author         = "Bruno Frank"
  p.email          = "bfscordeiro@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ['xml-simple']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }