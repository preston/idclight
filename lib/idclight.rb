# For XPath support.
# require 'rexml/document'
require 'hpricot'
require 'open-uri'

module IDConverter
	
	module Light
		
		# Organism type constants
		@@HUMAN = 'Hs'
		@@MOUSE = 'Mm'
		@@RAT = 'Rn'
		
		# ID type constants.
		@@UNIGENE		= 'ug'
		@@ENTREZ		= 'entrez'
		@@ENSEMBL		= 'ensumbl'
		@@HUGO			= 'hugo'
		@@GENBANK		= 'acc'
		@@CLONE			= 'clone'
		@@AFFYMETRIX	= 'affy'
		@@REFSEQ_RNA	= 'rsdna'
		@@REFSEQ_PEPTIDE	= 'rspep'
		@@SWISSPROT		= 'swissp'
		
		
		# Originally taken from http://idclight.bioinfo.cnio.es/
		# idtype refers to the type of ID from which you want to obtain further information. Current options are:
		# ug (UniGene cluster)
		# entrez (EntrezGene ID)
		# ensembl (Ensembl Gene)
		# hugo (HUGO Gene Name)
		# acc (GenBank accession)
		# clone (Clone ID)
		# affy (Affymetrix ID)
		# rsdna (RefSeq_RNA)
		# rspep (RefSeq_peptide)
		# swissp (SwissProt name)
		# id is the ID of the gene or clone for which more information is required. 
		# org is the organism you are working with. Three different organisms are available Hs (Human - Homo sapiens), Mm (Mouse - Mus musculus), and Rn (Rat - Rattus norvegicus).
		def search(id_type, id, organism = @@HUMAN)
			return nil if id.nil? || id_type.nil? || organism.nil?
			url = "http://idclight.bioinfo.cnio.es/idclight.prog?id=#{id}&idtype=#{id_type}&org=#{organism}"
			response = ''
			
			begin
			doc = Hpricot(URI.parse(url).read)
			elements = doc.search("//table[@class='sample']//tr")
			data = {}
			# last = nil
			elements.each do |e|
				tds = e/'td'
				tds.size == 2
				t1 = tds[0].text
				t2 = tds[1].text
				if t1.nil? || t1 == ''
					// TODO
				else
					data[t1] = t2
				end
							end
		 		rescue SocketError => e
			response = nil
		end
 	   		puts response
		end
		
		def hugo_to_entrez(id, organism = @@HUMAN)
			convert(@@HUGO, @@ENTREZ, id, organism)
		end
		
	end
	
end