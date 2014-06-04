#Complete plastid genome assembly for invasive plant, Centaurea diffusa
#Kathryn G. Turner and Chris J. Grassa
#June 8, 2014

#Figure 1, Global range map for Centaurea diffusa
#With sequenced population (TR001) highlighted

#Made using rworldmap package
# South, Andy 2011 rworldmap: A New R package for Mapping Global Data. The R Journal Vol. 3/1 : 35-43. 

library(rgdal) # Commands for reprojecting the vector data.
library(rworldmap) # Recently updated mapping program.
library(rworldxtra) # Add-ons for rworldmap.


png("fig1popmap_TR001.png", width=800, height = 600, pointsize = 16)

projectionCRS <- CRS("+proj=laea +lon_0=0.001 +lat_0=89.999 +ellps=sphere") #the ellps 'sphere' has a radius of 6370997.0m
par(mai=c(0,0,0.2,0)) #,xaxs="i",yaxs="i"
sPDF <- getMap()[-which(getMap()$ADMIN=='Antarctica')] 
sPDF <- spTransform(sPDF, CRS=projectionCRS)
setLims <- TRUE #FALSE back to whole world

if ( !setLims )
{
  xlim <- ylim <- NA
} else
{
  ### TRY FIDDLING WITH THESE LIMITS ###
  xlimUnproj <- c(-52,120)
  ylimUnproj <- c(10,30)
  sPointsLims <- data.frame(x=xlimUnproj, y=ylimUnproj)
  coordinates(sPointsLims) = c("x", "y")
  proj4string(sPointsLims) <- CRS("+proj=longlat +ellps=WGS84")
  sPointsLims <- spTransform(sPointsLims, CRS=projectionCRS)
  xlim <- coordinates(sPointsLims)[,"x"]
  ylim <- coordinates(sPointsLims)[,"y"]  
}


#setup a color code column filled with 1's
sPDF$colCode <- 1 #background countries
#set codes for specified countries
sPDF$colCode[ which(sPDF$ADMIN %in% c("Canada","United States of America"))] <- 2 #invasive range
sPDF$colCode[ which(sPDF$ADMIN %in% c("Armenia","Azerbaijan", "Bulgaria", "Georgia", 
                                      "Greece", "Moldova", "Romania","Russia", "Turkey",
                                      "Ukraine", "Serbia"))] <- 3 #native range
sPDF$colCode[ which(sPDF$ADMIN %in% c("Poland", "Belarus", "Italy", "Syria", "Czech Republic",
                                      "Estonia", "Switzerland","Latvia","Lithuania", 
                                      "Slovenia", "Serbia","Austria","Belgium", "France",
                                      "Germany","Hungary","Luxembourg","Norway","Slovakia",
                                      "Spain", "United Kingdom", "Kazakhstan", "Turkmenistan", "China"))] <- 4 #naturalized range

#create a colour palette - note for each value not for each country
#in order (non highlighted countries, invasive, native, naturalized)
colourPalette <- c("lightgray","#666699","#66CC00", "#99FF99")

par(mar=c(0,0,0,0))
mapCountryData(sPDF, nameColumnToPlot="colCode", mapTitle=NA,
               colourPalette=colourPalette, borderCol ='gray24', addLegend = FALSE,
               xlim=xlim, ylim=ylim, catMethod=c(0,1,2,3,4))
#note that catMethod defines the breaks and values go in a category if they are <= upper end 

# plot TR001
popNat <- read.csv("NatPopCoord.csv")
# Population ID  Latitude	Longitude	Voucher Accession
# ....
# TR001	         41.75111	27.24778	V236765
TR001 <- popNat[8,]

coordinates(TR001) = c("Longitude", "Latitude")
proj4string(TR001) <- CRS("+proj=longlat +ellps=WGS84")
sPointsDFNat <- spTransform(TR001, CRS=projectionCRS)
points(sPointsDFNat, pch=TR001$pch, cex=1.2) #pch2 for triangles
text(sPointsDFNat, labels = sPointsDFNat$Pop, cex=1.2, pos=3)

#Latitude and longitude lines
llgridlines(sPDF, easts=c(-90,-180,0,90,180), norths=seq(0,90,by=15), 
            plotLabels=FALSE, ndiscr=1000) #ndiscr=num points in lines
markings <- data.frame(Latitude=as.numeric(c(75,60,45,30,15,85,85)), Longitude=as.numeric(c(-45,-45,-45,-45,-45,0,180)),name=c("75", "60","45","30","15","0","180"))
coordinates(markings) = c("Longitude", "Latitude")
proj4string(markings) <- CRS("+proj=longlat +ellps=WGS84")
sPointsDFmark <- spTransform(markings, CRS=projectionCRS)
text(sPointsDFmark, labels = sPointsDFmark$name, cex=1.2) #pch2 for triangles

#legends
legend("bottomleft", c("Invasive", "Native","Present, status unknown"), fill=c("#666699","#66CC00", "#99FF99"),
       title="Range", bg="white", cex=1.5)
box(lty="solid", col = "black")
# #shameless plug !
mtext("map made using rworldmap", line=-1, side=1, adj=1, cex=0.6)

# 
dev.off()
