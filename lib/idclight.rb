# For XPath support.
# require 'rexml/document' # ...was choking too much on bad XML.
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
    @@ENSEMBL		= 'ensembl'
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
      data = nil
      
      begin
        doc = Hpricot(URI.parse(url).read)
        elements = doc.search("//table[@class='sample']//tr")
        data = {}
        # last = nil
        elements.each do |e|
          tds = e/'td'
          tds.size == 2
          t1 = tds[0].inner_html
          t2 = tds[1].inner_html
          if t1.nil? || t1 == ''
            # TODO
          else
            data[t1] = t2
          end
        end
      rescue SocketError => e
        data =nil
      end
      data
    end
    
    def hugo_id_to_entrez_id(id, organism = @@HUMAN)
      data = search(@@HUGO, id, organism)
      extract_entrez_id(data)
    end

    def hugo_id_to_ensembl_id(id, organism = @@HUMAN)
      data = search(@@HUGO, id, organism)
      extract_ensembl_id(data)
    end

    def ensembl_id_to_entrez_id(id, organism = @@HUMAN)
     	data = search(@@ENSEMBL, id, organism)
 		extract_entrez_id(data)
    end

    def ensembl_id_to_hugo_id(id, organism = @@HUMAN)
     	data = search(@@ENSEMBL, id, organism)
 		extract_hugo_id(data)
    end

	def extract_entrez_id(data)
		ent = data['Entrez Gene']
		id = nil
		if ent
			doc = Hpricot(ent)
	        doc.search('//a').each do |e|
	          tmp = e.inner_html.to_i
	          id = tmp if tmp != 0 
	        end
		end	
		id
	end
	
	def extract_hugo_id(data)
		ent = data['HUGO']
		extract_last_link_text(ent)
	end

	def extract_ensembl_id(data)
		ent = data['Ensembl']
		extract_last_link_text(ent)
	end

	def extract_last_link_text(ent)
		id = nil
		if ent
			doc = Hpricot(ent)
	        doc.search('//a').each do |e|
	          tmp = e.inner_html
	          id = tmp if !tmp.nil? && tmp != ''
	        end
		end	
		id
	end
    
  end
  
  
end