#reads aligned to Latuca chlp
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.78675147.k31.hist", head=T)
names(dat)
# attach(dat)
plot(dat$multiplicity, dat$frequency, type="hist")
sub<-subset(dat, multiplicity>400)
sub1<-subset(sub,sub$multiplicity<600)
plot(sub1$multiplicity, sub1$frequency, type="hist")
sub<-subset(dat, multiplicity>200)
sub1<-subset(sub,sub$multiplicity<1000)
plot(sub1$multiplicity, sub1$frequency, type="hist")
sub<-subset(dat, multiplicity>10)
plot(sub$multiplicity, sub$frequency, type="hist")
sub<-subset(dat, multiplicity>10)
sub1<-subset(sub,sub$multiplicity<600)
plot(sub1$multiplicity, sub1$frequency, type="hist")
# detach(dat)

#PhiX
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.9626372.k31.hist", head=T)
plot(dat$multiplicity, dat$frequency, type="hist")
# plot(dat[dat$multiplicity>500,]$mulitplicity, dat[dat$multiplicity>500,]$frequency)
sub <- subset(dat, multiplicity>200)
plot(sub$multiplicity, sub$frequency, type="hist")

#Helianthus mt
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.HA412fertile.k31.hist", head=T)
plot(dat$multiplicity, dat$frequency, type="hist")
# plot(dat[dat$multiplicity>500,]$mulitplicity, dat[dat$multiplicity>500,]$frequency)
sub <- subset(dat, dat$multiplicity>3)
sub1 <- subset(sub, sub$multiplicity<100)
plot(sub1$multiplicity, sub1$frequency)
qplot(sub1$multiplicity, sub1$frequency)

#fit curve to histogram, find minima
lo <- loess(sub1$frequency~sub1$multiplicity)
plot(sub1$multiplicity, sub1$frequency)
lines(predict(lo), col='red', lwd=2)
xl <- seq(min(sub1$multiplicity),max(sub1$multiplicity), (max(sub1$multiplicity) - min(sub1$multiplicity))/1000)
lines(xl, predict(lo,xl), col='red', lwd=2)

> freq <- matrix(sub1$frequency)
> freq[which.min(freq[2]),1]

####
sub1 <- sub1[with(sub1, order(multiplicity)), ]
freq <- sub1$frequency
mul <- sub1$multiplicity
# c(10,8,6,4,3,2,3,2,1,3,8,10,8,7,8,9,10)
library(zoo)
freqz <- as.zoo(freq)
# rollapply(freqz, 3, function(x) which.min(x)==2)
#    2     3     4     5     6     7 
#FALSE FALSE FALSE  TRUE FALSE FALSE 
# rollapply(xz, 3, function(x) which.max(x)==2)
# #    2     3     4     5     6     7 
# #FALSE  TRUE FALSE FALSE FALSE  TRUE 

rfreqz <- rollapply(freqz, 3, function(x) which.min(x)==2)
minima <- index(rfreqz)[coredata(rfreqz)]
#[1] 3 7

mul[8]
sub1[8,]
sub1[51,]

p <- qplot(x=sub1$multiplicity, y=sub1$frequency) 
p
p+ annotate("point", x=mul[8], y=freq[8], size = 5, color = "green")+
  annotate("point",x=mul[51], y=freq[51], size = 5, color = "red")

########Minima function############
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
  binned3$avg <- round((binned3$X1 + binned3$X2)/2)
  
  print(dat[dat$multiplicity==binned3[minima[1],]$avg,])
  
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

# dat <- read.table("Index_1.TR001_1L.k31.alldata.hist", head=T) #all reads
# dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.78675147.k31.hist", head=T) #helianthus mt
dat <- read.table("HI.0767.001.Index_1.TR001_1L.TO.HA412fertile.k31.hist", head=T) #latuca cp

plot(dat$multiplicity, dat$frequency, type="hist")
subdat <- dat[dat$multiplicity>3 & dat$multiplicity<300,]
plot(subdat$multiplicity, subdat$frequency)

Minima.mer(dat)
Minima.mer(dat,window=4, cutoff1 = 10,cutoff2=200, extra=TRUE)
Minima.mer(dat, window = 4, extra=TRUE)

# head(subdat[subdat$multiplicity>59 &subdat$multiplicity<60.2,])
# head(dat[dat$multiplicity>59 &dat$multiplicity<60.2,])
# dat[dat$multiplicity>59 &dat$multiplicity<60.2,]
# sub <- dat[dat$multiplicity<100 & dat$multiplicity>3,]
# 
# sub <- sub[with(sub, order(multiplicity)), ]
# freq <- sub$frequency
# mul <- sub$multiplicity
# 
# binned <- data.frame(mul=mul, bin = cut(mul, breaks=100))
# binned2 <- aggregate(freq~bin, data=binned, sum)
# str(binned2)
# freqz <- as.zoo(binned2$freq)
# rfreqz <- rollapply(freqz, 4, function(x) which.min(x)==2)
# minima <- as.vector(index(rfreqz)[coredata(rfreqz)])
# 
# binned3 <- binned2
# binned4<-data.frame(do.call('rbind', strsplit(as.character(binned3$bin), ',', fixed=TRUE)))
# binned3 <- cbind(binned3, binned4)
# head(binned3)
# 
# str(binned3)
# binned3$X1 <- as.numeric(gsub( "\\(", "", as.character(binned3$X1)))
# binned3$X2 <- as.numeric(gsub( "\\]", "", as.character(binned3$X2)))
# dat[dat$multiplicity>=binned3[minima[1],]$X1 & dat$multiplicity<=binned3[minima[1],]$X2,]
# 
# binned3$avg <- round((binned3$X1 + binned3$X2)/2)
# 
# str(dat)
# summary(dat)
# dat[dat$multiplicity == binned3[minima[1],]$avg,]
# dat[dat$multiplicity < 13,]
# 
# binned3[minima[1],]
# binned3[minima[1],]$avg
# dat[dat$multiplicity>=binned3[minima[1],]$X1,]
# dat[dat$multiplicity<=binned3[minima[1],]$X2,]

# binned3$ubin <- unlist(strsplit(binned3$ubin.X1, "\("))
# binned3$ubin <- substr(as.character(binned3$ubin.X1), 2, 100000)

# sub <- dat[dat$multiplicity<700 & dat$multiplicity>300,]
# 
# sub <- sub[with(sub, order(multiplicity)), ]
# # freq <- sub$frequency
# mul <- sub$multiplicity
# mulbin <- as.vector(bapply(mul, freq, cut.arg=100)) 
# 
# freqz <- as.zoo(freq)
# mulbinz <- as.zoo(mulbin)
# 
# rfreqz <- rollapply(freqz, 30, function(x) which.min(x)==2)
# minima <- as.vector(index(rfreqz)[coredata(rfreqz)])
# minima
# sub[69,]
# 
# rmulbinz <- rollapply(mulbinz, 30, function(x) which.min(x)==2)
# minima <- as.vector(index(rmulbinz)[coredata(rmulbinz)])
# minima
# p <- qplot(x=sub$multiplicity, y=sub$frequency) 
# p+ annotate("point", x=mulbin[minima[1]], y=freq[minima[1]], size = 5, color = "green")+
#          annotate("point",x=mulbin[minima[2]], y=freq[minima[2]], size = 5, color = "red")

# freq <- sub$frequency
# mul <- sub$multiplicity
# 
# binned <- data.frame(mul=mul, bin = cut(mul, breaks=100))
# binned2 <- aggregate(freq~bin, data=binned, sum)
# plot(binned2$freq)
# 
# bin1 <- as.vector(cut(sub$multiplicity, breaks=100))
# bin2 <- cbind(sub, bin1)
# bin3 <- ddply(sub,.(frequency), binfreq=sum(frequency))
# # grBatH2 <- ddply(grdatB, .(Trt, Origin), summarize, totcount = length(BoltedatH))
# # grBatH2$xmax <- cumsum(grBatH2$totcount)
# # grBatH2$xmin <- grBatH2$xmax-grBatH2$totcount
# # grBatH3 <- ddply(grdatB, .(Trt, Origin, BoltedatH), summarize, count = length(BoltedatH))
# # grBatH <- merge(grBatH2,grBatH3, all.y=TRUE)
# # grBatH$Trt <- factor(grBatH$Trt, c("cont","nut def","cut"))
# 
# sub <- dat[dat$multiplicity>10 & dat$multiplicity<100000,]
# qplot(cut(sub$multiplicity,breaks=100))
# plot(cut(sub$multiplicity, breaks=100), sub$frequency, type="hist")

##############3
# bapply <- function(X, Y, FUN = NULL,
#                    pretty.fn = pretty, pretty.arg = NULL,
#                    cut.fn    = cut,    cut.arg    = NULL, ...) {
#   bpts  <- do.call("pretty", c(list(Y), pretty.arg))
#   INDEX <- do.call("cut", c(list(Y), cut.arg))
#   tapply(X, INDEX, FUN, ...)
# }
##############
# use some model ?lm and plot predicted values with line
# ??smooth will give you many functions for smoothing data e.g.
# ?loess
# ?supsmu
# ?spline 