#Complete plastid genome assembly for invasive plant, Centaurea diffusa
#Kathryn G. Turner and Chris J. Grassa
#June 8, 2014

#Figure 3, Histogram of Centaurea diffusa 31-mer reads aligned to Lactuca sativa plastome

library(ggplot2)

#reads aligned to Latuca plastome
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.78675147.k31.hist", head=T)

sub<-subset(dat, multiplicity>10)

png("kmercount.png",width=800, height = 600, pointsize = 16)
ggplot(sub, aes(multiplicity, frequency))+geom_bar(stat="identity")+xlab("k-mer Multiplicity")+ylab("k-mer Frequency")
dev.off()
