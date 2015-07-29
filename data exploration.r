getwd()
setwd("D:/directory")
eggs <- read.table("eggsperiment.txt", header = T)
head(eggs)
summary(eggs)
# model for the mean
fit <- lm(Mean~A+B+C+D, data = eggs)
summary(fit)
anova(fit)
qqnorm(rstandard(fit), pch = 19)
abline(0,1)
fit2 <- lm(Mean~A*B*C*D, data = eggs)
summary(fit2)
anova(fit2)
fit21 <- lm(Mean~A+B+D+A:B:D, data = eggs)
summary(fit21)
anova(fit21)
# a, b, d, abd - sign effects at alpha 0.1
# sd model
# d - causes large variation in the response
fit3 <- lm(log(SD)~A*B*C*D, data = eggs)
summary(fit3)
anova(fit3)
# model with 4 replicates
eggs1 <- read.table("eggsperimentfull.txt", header = T)
head(eggs1)
summary(eggs1)
fit4 <- lm(y~A*B*C*D, data = eggs1)
summary(fit4)
anova(fit4)
qqnorm(rstandard(fit4), pch = 20)
abline(0,1)
# leave only sig terms at alpha = 0.1
fit5 <- lm(y~A+B+D+A:B:D, data = eggs1)
summary(fit5)
anova(fit5)
qqnorm(rstandard(fit5), pch = 20)
abline(0,1)
par(mfrow = c(2,2))
with(eggs1, interaction.plot(A,B,y,type="l",pch=19, fixed=T,xlab="A",ylab="average response"))
with(eggs1, interaction.plot(B,C, y,type="l",pch=19, fixed=T,xlab="B",ylab="average response"))
with(eggs1, interaction.plot(A,C, y,type="l",pch=19, fixed=T,xlab="A",ylab="average response"))
with(eggs1, interaction.plot(A,D, y,type="l",pch=19, fixed=T,xlab="A",ylab="average response"))

library(rsm)
fit11 = rsm(y~FO(A,x2)+TWI(x1,x2), data = eggs1)
par(mfrow=c(1,2), oma = c(0, 0, 3, 0), cex = 0.7)
contour(fit11, ~x1 + x2, image = TRUE, at = list(x1="1"))
contour(fit11, ~x1 + x2, image = TRUE, at = list(x2="-1"))
mtext("Contour plots for regression model on hexagon canonycal analysis", outer = TRUE, cex = 1.25)

par(mfrow=c(1,2), oma = c(0, 0, 3, 0), cex = 0.7)
persp(fit11, ~x1 + x2, at = list(x2 ="-1"), zlab="Tool Life (hours)", col = "darkgrey", contours = list(z="bottom", col = "grey"))
persp(fit11, ~x1 + x2, at = list(x2 ="1"), zlab="Tool Life (hours)", col = "darkgrey", contours = list(z="bottom", col = "grey"))
mtext("Response surface plots for regression model on machine life", outer = TRUE, cex = 1.25)