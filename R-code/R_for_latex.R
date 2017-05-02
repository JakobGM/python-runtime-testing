rm(list=ls())
graphics.off()

## ---- setup

library(FrF2)
library(MASS)
library(lattice)

get_lenth <- function(effects, alpha, pareto=FALSE){
  abseffects <- abs(effects)[-1]
  median_abseffects <- median(abseffects)
  s0 = 1.5*median_abseffects
  new_abseffects = abseffects[abseffects < 2.5*s0]
  pse = 1.5*median(new_abseffects)
  sign_eff <- abseffects[
    abseffects > qt(1-alpha/2,(length(effects)-1)/3)*pse]
  if (pareto){
    barplot(sort(abseffects), horiz=TRUE,las=2)
    abline(v=qt(1-alpha/2,(length(effects)-1)/3)*pse)
  }
  return(sign_eff)
}

get_lambda <- function(model){
  bc_res <- boxcox(model,c(-1,0.01,1),plotit=FALSE)
  lambda_i <- which.max(bc_res$y)
  lambda = bc_res$x[lambda_i]
  return(lambda)
}

## ---- full_model

newrun = FALSE

if (newrun){
  plan <- FrF2(nruns=16,nfactors=4)
  plan
  write.csv(plan, file="csv/plan.csv")
  save(plan,file="R-code/plan.RData")
} else {
  load("R-code/plan.RData")
}

data <- read.csv(file="csv/results.csv")
plan <- add.response(plan, data)

lm4 <- lm(time~(.)^4,data=plan)
effects4 <- 2*lm4$coeff
sign_eff <- get_lenth(effects4, 0.2, pareto=TRUE)
sign_eff

## ---- reduced_model_1

lm3 <- lm(time~(.)^3, data=plan)
summary(lm3)

## ---- reduced_model_2

effects2 <- 2*lm2$coeff

## ---- reduced_model_2_tf

lm2 <- lm(time~(.)^2, data=plan)
lambda <- get_lambda(lm2)
tf_plan <- plan
tf_plan$time = (data$time^lambda - 1)/lambda
lm2_tf <- lm(time~(.)^2,data=tf_plan)

## ---- analysis

summary(lm2_tf)

## ---- effects

MEPlot(lm2_tf)
IAPlot(lm2_tf)

## ---- residuals

par(mfrow=(c(1,2)))
plot(lm2$fitted,rstudent(lm2_tf),pch=20)
qqnorm(rstudent(lm2_tf),pch=20)
qqline(rstudent(lm2_tf))



