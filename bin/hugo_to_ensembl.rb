#!/usr/bin/env ruby

current_dir = File.dirname(File.expand_path(__FILE__))
lib_path = File.join(current_dir, '..', 'lib')
$LOAD_PATH.unshift lib_path

require 'rubygems'

require 'idclight'

include IDConverter::Light


code = 0
puts "\n"
puts "IDCLight (IDConverter Light) command-line converter utility, by Preston Lee. (Screen scapes http://idclight.bioinfo.cnio.es for data.)"
if ARGV.length == 1
	id = ARGV[0]
	r = hugo_id_to_ensembl_id(id)
	if r.nil?
	  puts "No result. Bad input, perhaps? :("
	  code = 1
	else
		puts "\n#{r}"
	end
else
	puts "\n\tUsage: #{__FILE__} <id>"
end
puts "\n"

exit(code)

