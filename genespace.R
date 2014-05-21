#genespace

genespace <- scan(file="Index_1.TR001_1L.TO.Cdiff_transcriptomes.depth.c3.txt", what="integer", sep="\t")
head(genespace)
gs <- as.numeric(genespace)

# library(ggplot2)
# 
# library(plyr)
# 
# qplot(gs)

# hist(genespace)
hist(gs, xlim = c(0, 9000), ylim=c(0, 100000), breaks=100 )
hist(gs, xlim = c(0, 1000), breaks=1000 )
