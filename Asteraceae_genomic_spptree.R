#phylogeny for alignment

library(devtools)
install_github("taxize_", "ropensci")

library(taxize)
library(XML)
library(reshape2)

# Define a species list
# 
spplist <- c("Centaurea diffusa","Artemisia frigida","Jacobaea vulgaris",
             "Ageratina adenophora","Lactuca sativa","Helianthus annuus",
             "Guizotia abyssinica","Parthenium argentatum","Helianthus strumosus",
             "Helianthus decapetalus","Helianthus grosseserratus", "Helianthus tuberosus",
             "Helianthus divaricatus", "Helianthus giganteus","Helianthus hirsutus", 
             "Helianthus maximiliani", "Chrysanthemum indicum", "Chrysanthemum x morifolium")
# 

# 
# Make the tree
# 
# Plain species tree
# 
tree <- phylomatic_tree(taxa = spplist, storedtree='smith2011')
tree$tip.label <- taxize_capwords(tree$tip.label)

png("Asteraceae_plastome_tree.png", width=600, height = 600, pointsize = 16)

plot(tree, cex=0.75, main="Published plastomes from the Asteraceae")

dev.off()

# legend("bottomleft", legend = c("Weed", "Not a weed"), fill = c("#024DFD", "#ED6500"))