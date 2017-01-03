################################################################################
# Updated version of the R code for the analysis in:
#
#   "Attributable risk from distributed lag models"
#   Antonio Gasparrini & Michela Leone
#   BMC Medical Research Methodology 2014
#   http://www.ag-myresearch.com/bmcmrm2014.html
#
# Update: 17 March 2016
# For any problem with this code, please contact antonio.gasparrini@lshtm.ac.uk
# Please refer to the original code for any copyright issue
#
#  See www.ag-myresearch.com for future updates
################################################################################

# LOAD THE FUNCTION attrdl
# (READ THE ACCOMPANYING PDF FOR DOCUMENTATION)
source("attrdl.R")


# OVERALL CUMULATIVE RR AT 1ST AND 99TH PERCENTILES
with(cp2,cbind(allRRfit,allRRlow,allRRhigh))
# REPORTED IN THE MAIN TEXT

# GLOBAL BACKWARD ATTRIBUTABLE RISK OF TEMPERATURE (NUMBER AND FRACTION)
attrdl(lndn$tmean,cb,lndn$death,model,type="an",cen=cen)
attrdl(lndn$tmean,cb,lndn$death,model,cen=cen)
# COMPARE WITH TABLE 1

# GLOBAL FORWARD ATTRIBUTABLE RISK OF TEMPERATURE (NUMBER AND FRACTION)
attrdl(lndn$tmean,cb,lndn$death,model,dir="forw",type="an",cen=cen)
attrdl(lndn$tmean,cb,lndn$death,model,dir="forw",cen=cen)

# WITH EMPIRICAL CONFIDENCE INTERVALS
# (NB: eCI ARE DIFFERENT AS OBTAINED EMPIRACALLY FROM RANDOM SAMPLES)
quantile(attrdl(lndn$tmean,cb,lndn$death,model,sim=T,nsim=1000,cen=cen),c(0.025,0.975))
# COMPARE WITH TABLE 1

# ATTRIBUTABLE FRACTION COMPONENT DUE TO HEAT
attrdl(lndn$tmean,cb,lndn$death,model,cen=cen,range=c(cen,100))*100
# COMPARE WITH TABLE 1

# ATTRIBUTABLE FRACTION COMPONENT DUE TO MILD COLD
attrdl(lndn$tmean,cb,lndn$death,model,cen=cen,range=c(perc[1],cen))*100
# COMPARE WITH TABLE 2

# DAILY ATTRIBUTABLE DEATHS DUE TO COLD IN SECOND MONTH, FORWARD & BACKWARD
attrdl(lndn$tmean,cb,lndn$death,model,tot=F,type="an",cen=cen,range=c(-100,cen))[31:60]
attrdl(lndn$tmean,cb,lndn$death,model,tot=F,type="an",dir="forw",cen=cen,
  range=c(-100,cen))[31:60]

#
