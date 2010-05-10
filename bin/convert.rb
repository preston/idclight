#!/usr/bin/env ruby

current_dir = File.dirname(File.expand_path(__FILE__))
lib_path = File.join(current_dir, '..', 'lib')
$LOAD_PATH.unshift lib_path

require 'rubygems'

require 'idclight'

include IDConverter::Light


code = 0
puts "\n"
puts "IDCLight (IDConverter Light) command-line converter utility. (Uses http://idclight.bioinfo.cnio.es for data.)"
org = @@HUMAN
if ARGV.length >= 2 and ARGV.length <= 3
	id_type = ARGV[0]
	id = ARGV[1]
	org = ARGV[2] unless ARGV[2].nil?
	r = convert(id_type, id, org)
	if r.nil?
	  puts "No result. Bad input, perhaps? :/"
	  code = 1
	else
		puts "\n"
	end
else
	puts "\n\tUsage: #{__FILE__} <id_type> <id> [organism (defaults to human)]"
end
puts "\n"

exit(code)

