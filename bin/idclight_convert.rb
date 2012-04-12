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
	r = search(id_type, id, org)
	if r.nil?
	  puts "No result. Bad input, perhaps? :/"
	  code = 1
	else
		puts r
	end
else
	puts "\n\tUsage: #{__FILE__} <id_type> <id> [organism (defaults to human)]"
	puts <<EOF
	
	From the website:
	
	idtype refers to the type of ID from which you want to obtain further information.
	Current options are: ug (UniGene cluster), entrez (EntrezGene ID),
	ensembl (Ensembl Gene), hugo (HUGO Gene Name), acc (GenBank accession),
	clone (Clone ID), affy (Affymetrix ID), rsdna (RefSeq_RNA),
	rspep (RefSeq_peptide), and swissp (SwissProt name). 
	
	id is the ID of the gene or clone for which more information is required. 
	
	org is the organism you are working with. Three different organisms are available
	Hs (Human - Homo sapiens), Mm (Mouse - Mus musculus), and Rn (Rat - Rattus norvegicus).
EOF
end
puts "\n"

exit(code)

