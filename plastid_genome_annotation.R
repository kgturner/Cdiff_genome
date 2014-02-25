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

#modify Dogma summary file to include column names
#looks like this, may need to add extra tabs at end of line?
# line 18 has extraneous "
# > head(plastid)
# Start  End GeneName Strand Annotated Exon                  GeneInfo  X
# 1    69  143 trnH-GUG      -         A    N                     tRNA- NA
# 2   527 1585     psbA      -         A    N photosystem II protein D1 NA
# 3  2115 3632     matK      -         A    N                maturase K NA
# 4  4367 4403 trnK-UUU      -         A    N                     tRNA- NA
# 5  5192 5404    rps16      -         A    N     ribosomal protein S16 NA
# 6  7230 7301 trnQ-UUG      -         A    N                     tRNA- NA
plastid <- read.delim("plastid_finishing/TR001_1L.plastid.0.3.withNs.DogmaSummary2.txt", header=TRUE)
head(plastid)
summary(plastid$X)
plastid <- plastid[,c(1:7)]

commongenes <- read.table("plastid_80_gene_list.txt", header=TRUE, sep="\t")

commongenes$ID %in% plastid$GeneName
missing <- setdiff(commongenes$ID, plastid$GeneName)
commongenes$ID[c(2,6,36,47,49,70,71)] #lhbA is in plastid list; rps12 and rps12_3end are in list - perhaps equivalent?
[1] apt         apt         pubs        SBN         psbZ/lhbA   rps12_exon1 rps12_exon2

# > "a" %in% c("a","b","c","d")
# [1] TRUE
# > "f" %in% c("a","b","c","d")
# [1] FALSE
# > c("a","b") %in% c("a","b","c","d")
# [1] TRUE TRUE
# > c("a","f") %in% c("a","b","c","d")
# [1]  TRUE FALSE