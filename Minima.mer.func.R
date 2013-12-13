#####Minima.mer.func.R#####
#Kathryn Turner June 21, 2013

#Given an output kmer counting histogram table from jellyfish,
#find two minima around a peak

#input table from jellyfish
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.HA412fertile.k31.hist", head=T)
head(dat)
frequency multiplicity
1    513363            1
2      2024           10
3        25          100
4        21          101
5        18          102
6        22          103

#run function, requires instalation of zoo and ggplot2 packages
#specify data as dataframe, window along which local minima is determined, 
#cutoff1 (low) and cutoff2 (high) to subset data around specific peak
#breaks determines number of bins in subset
#default prints multiplicity and frequency of first minima
#extra plots graph and print starting AND stopping minima around peak (hopefully)
Minima.mer <- function(kmerdat, window=4, cutoff1=3, cutoff2=100, breaks=100, extra=FALSE){
  library(zoo)
  #limit scope of analysis around peak of interest w/cutoffs
  sub <- kmerdat[kmerdat$multiplicity<cutoff2 & kmerdat$multiplicity>cutoff1,]
  
  sub <- sub[with(sub, order(multiplicity)), ]
  freq <- sub$frequency
  mul <- sub$multiplicity
  
  binned <- data.frame(mul=mul, bin = cut(mul, breaks=breaks))
  binned2 <- aggregate(freq~bin, data=binned, sum)
  
  freqz <- as.zoo(binned2$freq)
  
  rfreqz <- rollapply(freqz, window, function(x) which.min(x)==2)
  
  minima <- as.vector(index(rfreqz)[coredata(rfreqz)])
  
  binned3 <- binned2
  binned4<-data.frame(do.call('rbind', strsplit(as.character(binned3$bin), ',', fixed=TRUE)))
  binned3 <- cbind(binned3, binned4)
  
  binned3$X1 <- as.numeric(gsub( "\\(", "", as.character(binned3$X1)))
  binned3$X2 <- as.numeric(gsub( "\\]", "", as.character(binned3$X2)))
  
  
  print(dat[dat$multiplicity>=binned3[minima[1],]$X1 & dat$multiplicity<=binned3[minima[1],]$X2,])
  
  if (extra==TRUE){
    print("Start minima")
    print(binned2[minima[1],])
    print("Stop minima")
    print(binned2[minima[2],])
    
    library(ggplot2)
    p <- qplot(x=binned2$bin, y=binned2$freq, xlab="binned multiplicity", ylab="binned frequency") 
    return(p+ annotate("point", x=binned2$bin[minima[1]], y=binned2$freq[minima[1]], size = 5, color = "green")+
             annotate("point",x=binned2$bin[minima[2]], y=binned2$freq[minima[2]], size = 5, color = "red"))
  }
}
#run function on data
Minima.mer(dat)
Minima.mer(dat,window=3)
Minima.mer(dat, extra=TRUE)

#play with window size to find appropriately located minima
#adjust cutoff1 and cutoff2 to subset data
