#Complete plastid genome assembly for invasive plant, Centaurea diffusa
#Kathryn G. Turner and Chris J. Grassa
#June 8, 2014

#Figure 2, Phylogenetic tree of complete plastomes available on NCBI within the Asteraceae

#Made using taxize package
# Chamberlain S, Szocs E. 2013. taxize - taxonomic search and retrieval in R. F1000Research 2.

library(devtools)
install_github("taxize_", "ropensci")

library(taxize)
library(XML)
library(reshape2)

# Define a species list
#from Nucleotide search at https://www.ncbi.nlm.nih.gov/nuccore/
# ("Asteraceae"[Organism] OR ("Asteraceae"[Organism] OR Asteraceae[All Fields])) AND chloroplast[All Fields] AND complete[All Fields] AND genome[All Fields]
# visually scan for length of sequence and statement "complete chloroplast" or "complete plastid"
spplist <- c("Centaurea diffusa","Artemisia frigida","Jacobaea vulgaris",
             "Ageratina adenophora","Lactuca sativa","Helianthus annuus",
             "Guizotia abyssinica","Parthenium argentatum","Helianthus strumosus",
             "Helianthus decapetalus","Helianthus grosseserratus", "Helianthus tuberosus",
             "Helianthus divaricatus", "Helianthus giganteus","Helianthus hirsutus", 
             "Helianthus maximiliani", "Chrysanthemum indicum", "Chrysanthemum x morifolium",
             "Praxelis clematidea")
# Praxelis aka Eupatorium catarium

# 
# Make the tree
# 
# species tree with sub-genera detail (Three species do not occur in this tree: 
# parthenium_argentatum, helianthus_sturmosus, chrysanthemum_xmorifolium)
# 
tree <- phylomatic_tree(taxa = spplist, storedtree='smith2011')
tree$tip.label <- taxize_capwords(tree$tip.label)

png("fig2Asteraceae_plastome_treeSmith.png", width=600, height = 600, pointsize = 12)

plot(tree, cex=1.1, main="Plastomes in the Asteraceae")
rect(14.8, 15.5, 20.2, 16.4, border="#66CC00",lwd=3)

dev.off()
