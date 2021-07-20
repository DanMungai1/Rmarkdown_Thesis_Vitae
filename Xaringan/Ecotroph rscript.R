# load the example data
library(EcoTroph)
data("ecopath_guinee")          
 # access the first six rows of the data.frame
View(head(ecopath_guinee))     
check.table(ecopath_guinee)
# default choice, sigmaLN
create.smooth(ecopath_guinee)                      
# sigmaLN=smooth_param*ln(TL-0.5)
create.smooth(ecopath_guinee, smooth_type = 2)    
# sigmaLN=ecopath_guinee$OI
create.smooth(ecopath_guinee, smooth_type = 3)    
# For smooth_type 2:
plot(create.smooth(ecopath_guinee, smooth_type=2))
#For smooth_type 3
plot(create.smooth(ecopath_guinee, smooth_type=3))
# transpose of the biomass column
Transpose(create.smooth(ecopath_guinee), ecopath_guinee, "biomass")    
# transpose of the catch.1 column
Transpose(create.smooth(ecopath_guinee), ecopath_guinee, "catch.1")     
# log scale for the biomasses
plot(Transpose(create.smooth(ecopath_guinee),
               ecopath_guinee, "biomass"), title="biomass", 
     log, legend.cex=0.6) 
plot(Transpose(create.smooth(ecopath_guinee),
               ecopath_guinee, "catch.1"), title="biomass", 
     log, legend.cex=0.6) 
# constant sigmaLN
create.ETmain(ecopath_guinee)                              
# sigmaLN=smooth_param*ln(TL-0.05) (cf. 2.1)
create.ETmain(ecopath_guinee,smooth_type=2)               
plot(create.ETmain(ecopath_guinee),legend.cex = 0.6)

res <- create.ETdiagnosis(create.ETmain(ecopath_guinee))

# test impacts on the ecosystem by applying the effort multiplier only on the groups "Barracudas+" and "Carangids"
res2 <- create.ETdiagnosis(create.ETmain(ecopath_guinee), Group = c("Barracudas+","Carangids"))
# plots impacts of global changes in fishing effort 
plot(res, scale = "log")       

plot_ETdiagnosis_isopleth(res, fleet1 = "catch.1", fleet2 = "catch.2")

MSY_0.1<-E_MSY_0.1(create.ETmain(ecopath_guinee))
x11() ; par(mfrow=c(1,2))
plot(row.names(MSY_0.1),MSY_0.1[,"E_0.1"],xlim=c(2,5.5),type="l",lwd=2,col="blue",xlab="Trophic levels",ylab="E 0.1")
plot(row.names(MSY_0.1),MSY_0.1[,"F_0.1"],xlim=c(2,5.5),type="l",lwd=2,col="blue",xlab="Trophic levels",ylab="F 0.1")

