# This is Greg Ross's (of the Graham Lab) standard procedure for plastid
# genome annotation:
# 
# 1 - Use Dogma to automate most of the annotation.
# http://dogma.ccbb.utexas.edu/
# 
# 2 - Verify that the genome contains all of the genes commonly found in
# plastid genomes.
# (list is attached)
# 
# 3 - Visualize the annotated genome with OGDraw.
# http://ogdraw.mpimp-golm.mpg.de/index.shtml


plastid <- read.table("dogma_textSum1.txt", header=TRUE)
head(plastid)

commongenes <- read.table("plastid_80_gene_list.txt", header=TRUE, sep="\t")

commongenes$ID %in% plastid$GeneName
missing <- setdiff(commongenes$ID, plastid$GeneName)
commongenes$ID[c(2,6,36,47,49,70,71)] #lhbA is in plastid list; rps12 and rps12_3end are in list - perhaps equivalent?


# > "a" %in% c("a","b","c","d")
# [1] TRUE
# > "f" %in% c("a","b","c","d")
# [1] FALSE
# > c("a","b") %in% c("a","b","c","d")
# [1] TRUE TRUE
# > c("a","f") %in% c("a","b","c","d")
# [1]  TRUE FALSE