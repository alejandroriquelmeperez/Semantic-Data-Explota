library(SPARQL)

#Query 1: Select  all  genes  that  encode  proteins  longer  than  400 aminoacids.

endpoint = "http://155.54.239.24:3044/blazegraph/namespace/Semantica_Alejandro_Riquelme_Perez/sparql"
query1 = "
prefix gr_data: <http://genomic-resources.eu/resource/>
prefix gr_ont: <http://genomic-resources.eu/ontology/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix uniprot: <https://www.uniprot.org/uniprot/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix up: <https://www.uniprot.org/core/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix obo: <http://purl.obolibrary.org/obo/>
prefix gene: <https://www.ncbi.nlm.nih.gov/gene/>
prefix taxon: <http://purl.uniprot.org/taxonomy/>
prefix go: <http://www.geneontology.org/go#>

SELECT ?gene ?protein ?length
WHERE{
  ?protein gr_ont:length ?length
  FILTER (?length > '400'^^xsd:int)
  ?protein gr_ont:encodedBy ?gene
}"

qd1 = SPARQL(endpoint,query1)
View((qd1$results))

#Query 2: Average, sum, maximum and minimum length of C.elegans proteins.
 
query2 = "
prefix gr_data: <http://genomic-resources.eu/resource/>
prefix gr_ont: <http://genomic-resources.eu/ontology/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix uniprot: <https://www.uniprot.org/uniprot/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix up: <https://www.uniprot.org/core/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix obo: <http://purl.obolibrary.org/obo/>
prefix gene: <https://www.ncbi.nlm.nih.gov/gene/>
prefix taxon: <http://purl.uniprot.org/taxonomy/>
prefix go: <http://www.geneontology.org/go#>

SELECT (AVG(?length) AS ?lenght_mean) 
	     (SUM(?length) AS ?lenght_sum) 
	     (MAX(?length) AS ?lenght_max) 
       (MIN(?length) AS ?lenght_min) 
WHERE{
  {?protein gr_ont:organism ?organism
  FILTER (?organism = taxon:6239)}
  ?protein gr_ont:length ?length
}"

qd2 = SPARQL(endpoint,query2)
View((qd2$results))

#Query 3: Select proteins with the word 'phosphatase' in their Uniprot label, indicating their cell location.

query3 = "
prefix gr_data: <http://genomic-resources.eu/resource/>
prefix gr_ont: <http://genomic-resources.eu/ontology/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix uniprot: <https://www.uniprot.org/uniprot/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix up: <https://www.uniprot.org/core/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix obo: <http://purl.obolibrary.org/obo/>
prefix gene: <https://www.ncbi.nlm.nih.gov/gene/>
prefix taxon: <http://purl.uniprot.org/taxonomy/>
prefix go: <http://www.geneontology.org/go#>

SELECT ?protein ?label ?cellular_location
WHERE {
  {?protein rdfs:label ?label
  FILTER regex(?label,'transferase')}
  {?protein gr_ont:part_of ?cellular_location}
}"

qd3 = SPARQL(endpoint,query3)
View((qd3$results))

#Query 4: Select all proteins and genes located in nucleus and chromosome I, respectively.

query4 = "
prefix gr_data: <http://genomic-resources.eu/resource/>
prefix gr_ont: <http://genomic-resources.eu/ontology/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix uniprot: <https://www.uniprot.org/uniprot/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix up: <https://www.uniprot.org/core/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix obo: <http://purl.obolibrary.org/obo/>
prefix gene: <https://www.ncbi.nlm.nih.gov/gene/>
prefix taxon: <http://purl.uniprot.org/taxonomy/>
prefix go: <http://www.geneontology.org/go#>

SELECT ?molecule ?location
WHERE {
  {?molecule gr_ont:part_of ?location
  FILTER regex(str(?location),'Nucleus')}
  UNION
  {?molecule gr_ont:located_in ?location
  FILTER (?location = 'Chromosome I')} 
}"

qd4 = SPARQL(endpoint,query4)
View((qd4$results))

#Query 5: Select all proteins that have Mn+2 as cofactor, the organism they belong to and their tissue specificity for optionally.

query5 = "
prefix gr_data: <http://genomic-resources.eu/resource/>
prefix gr_ont: <http://genomic-resources.eu/ontology/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix uniprot: <https://www.uniprot.org/uniprot/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix up: <https://www.uniprot.org/core/>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix obo: <http://purl.obolibrary.org/obo/>
prefix gene: <https://www.ncbi.nlm.nih.gov/gene/>
prefix taxon: <http://purl.uniprot.org/taxonomy/>
prefix go: <http://www.geneontology.org/go#>


SELECT ?protein ?cofactor ?tissue ?organism
WHERE {
  ?protein gr_ont:cofactor ?cofactor
  FILTER (?cofactor = 'Mn+2'^^xsd:string)
  OPTIONAL
  {?protein gr_ont:Tissue_Specificity_Annotation ?tissue}
  ?protein gr_ont:organism ?organism
}"

qd5 = SPARQL(endpoint,query5)
View((qd5$results))

