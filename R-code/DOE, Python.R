rm(list=ls())
graphics.off()

library(FrF2)
newrun = FALSE

if (newrun){
  factor_names <- c("Swapping", "Iteration", "Returning", "Type")
  plan <- FrF2(nruns=16,nfactors=4,factor.names=factor_names)
  plan
  write.csv(plan, file="plan.csv")
  save(plan,file="plan.RData")
} else {
  load("C:/GitProject/TMA4267/plan.RData")
}

data <- read.csv(file="C:/GitProject/TMA4267/python-runtime-testing-master/results.csv")
plan <- add.response(plan, data)

lenth <- function(effects, alpha){
  abseffects <- abs(effects)
  median_abseffects <- median(abseffects)
  s0 = 1.5*median_abseffects
  new_abseffects = abseffects[abseffects <= 2.5*s0]
  pse = 1.5*median(new_abseffects)
  significant_effects <- abseffects[abseffects > qt(alpha/2,(length(effects)-1)/3)*pse]
  return(significant_effects)
}

lm4 <- lm(time~(.)^4,data=plan)
effects4 <- 2*lm4$coeff
lenth(effects4, 0.05)

lm3 <- lm(time~(.)^3,data=plan)
effects4 <- 2*lm3$coeff

lm <- lm(time~(.)^2, data=plan)
summary(lm)
anova(lm)

effects <- 2*lm$coeff

MEPlot(lm)
IAPlot(lm)
qqnorm(rstudent(lm),pch=20)
qqline(rstudent(lm))
plot(lm$fitted,rstudent(lm),pch=20)
cubePlot(lm,"A","B","C",round=1,size=0.33,main="")
