require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "idclight"
    gem.summary = %Q{Ruby programmnig interface to the IDCLight online database.}
    gem.description = %Q{A Ruby gem for accessing the freely available IDClight (IDConverter Light) web service, which convert between different types of gene IDs such as Hugo and Entrez. Queries are screen scraped from http://idclight.bioinfo.cnio.es.}
    gem.email = "conmotto@gmail.com"
    gem.homepage = "http://github.com/preston/idclight"
    gem.authors = ["Preston Lee"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_dependency "hpricot", ">= 0.8"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "idclight #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
