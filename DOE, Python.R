rm(list=ls())

## ---- analysis

install.packages("FrF2")
library(FrF2)
newrun = FALSE

if (newrun){
  factor_names <- c("A", "B", "C", "D")
  plan <- FrF2(nruns=16,nfactors=4,factor.names=factor_names)
  plan
  write.csv(plan, file="plan.csv")
  save(plan,file="plan.RData")
} else {
  load(plan)
}

data <- read.csv(file="mock_data.csv")
attach(data)
plan <- add.response(plan, y)
lm <- lm(y~(.)^3, data=plan)
summary(lm)


effects <- 2*lm$coeff
MEPlot(lm)
IAPlot(lm)
qqnorm(rstudent(lm),pch=20)
qqline(rstudent(lm))
plot(lm$fitted,rstudent(lm),pch=20)
cubePlot(lm,"A","B","C",round=1,size=0.33,main="") 

## ---- end
