#phylogeny for alignment

# install.packages("taxize")

library(taxize)
library(XML)
library(reshape2)

# Define a species list
# 
spplist <- c("Centaurea diffusa","Artemisia frigida","Jacobaea vulgaris","Ageratina adenophora","Lactuca sativa","Helianthus annuus","Guizotia abyssinica","Parthenium")
# 

# 
# Make the tree
# 
# Plain species tree
# 
tree <- phylomatic_tree(taxa = spplist)
tree$tip.label <- taxize_capwords(tree$tip.label)
plot(tree, cex=0.75)

legend("bottomleft", legend = c("Weed", "Not a weed"), fill = c("#024DFD", "#ED6500"))