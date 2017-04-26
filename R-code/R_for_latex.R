rm(list=ls())

## ---- setup

library(FrF2)
library(MASS)

## ---- full_model

newrun = FALSE

if (newrun){
  factor_names <- c("Swapping", "Iteration", "Returning", "Type")
  plan <- FrF2(nruns=16,nfactors=4,factor.names=factor_names)
  plan
  write.csv(plan, file="csv/plan.csv")
  save(plan,file="R-code/plan.RData")
} else {
  load("R-code/plan.RData")
}

data <- read.csv(file="csv/results.csv")
plan <- add.response(plan, data)

get_lenth <- function(effects, alpha){
  abseffects <- abs(effects)
  median_abseffects <- median(abseffects)
  s0 = 1.5*median_abseffects
  new_abseffects = abseffects[abseffects < 2.5*s0]
  pse = 1.5*median(new_abseffects)
  significant_effects <- abseffects[abseffects > qt(1-alpha/2,(length(effects)-1)/3)*pse]
  return(significant_effects)
}

get_lambda <- function(model){
  bc_res <- boxcox(model,c(-1,0.01,1),plotit=FALSE)
  lambda_i <- which.max(bc_res$y)
  lambda = bc_res$x[lambda_i]
  return(lambda)
}

lm4 <- lm(time~(.)^4,data=plan)
effects4 <- 2*lm4$coeff
sign_eff <- get_lenth(effects4, 0.2)
sign_eff

## ---- reduced_model_1

lm3 <- lm(time~(.)^3, data=plan)
summary(lm3)

## ---- reduced_model_2

lm2 <- lm(time~(.)^2, data=plan)
effects2 <- 2*lm2$coeff
lambda <- get_lambda(lm2)
tf_plan <- plan
tf_plan$time = (data$time^lambda - 1)/lambda


## ---- reduced_model_2_tf

lm2_tf <- lm(time~(.)^2,data=tf_plan)
summary(lm2_tf)
qqnorm(rstudent(lm2_tf),pch=20)
qqline(rstudent(lm2_tf))
plot(lm2$fitted,rstudent(lm2_tf),pch=20)

## ---- analysis

summary(lm2)
anova(lm2)

MEPlot(lm2)
IAPlot(lm2)
qqnorm(rstudent(lm2),pch=20)
qqline(rstudent(lm2))
plot(lm2$fitted,rstudent(lm2),pch=20)
cubePlot(lm2,"A","B","C",round=1,size=0.33,main="")

