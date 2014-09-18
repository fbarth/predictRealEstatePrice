# Function that returns Root Mean Squared Error
rmse <- function(error)
{
  sqrt(mean(error * error, na.rm = TRUE)) #eventual o modelo nao consegue predizer o valor de algum imovel
}

# Function that returns Mean Absolute Error
mae <- function(error)
{
  mean(abs(error), na.rm = TRUE)
}

set.seed(5000)
load('data/imoveis.rda')

ind <- sample(2, nrow(imoveis), replace = TRUE, prob = c(0.8, 0.2))
trainData <- imoveis[ind == 1, ]
testData <- imoveis[ind == 2, ]

model1 <- lm(preco ~ area + vagas + bairro, data=trainData)
summary(model1)
model2 <- lm(log(preco) ~ area + vagas + bairro, data=trainData)
summary(model2)
model3 <- lm(log(preco) ~ log(area) + log(vagas) + bairro, data=trainData)
summary(model3)
model4 <- lm(log(preco) ~ log(area) + log(vagas) + log(dormitorios) + log(suites) + bairro, data=trainData)
summary(model4)

testPred1 <- predict(model1, testData)
testPred2 <- predict(model2, testData)
testPred3 <- predict(model3, testData)
testPred4 <- predict(model4, testData)

error <- testPred1 - testData$preco
rmse(error)
mae(error)
#quantos imoveis o modelo nao conseguiu predizer o valor?
sum(is.na(error))

error2 <- exp(testPred2) - testData$preco
rmse(error2)
mae(error2)
#quantos imoveis o modelo nao conseguiu predizer o valor?
sum(is.na(error2))

error3 <- exp(testPred3) - testData$preco
rmse(error3)
mae(error3)
#quantos imoveis o modelo nao conseguiu predizer o valor?
sum(is.na(error3))

error4 <- exp(testPred4) - testData$preco
rmse(error4)
mae(error4)
#quantos imoveis o modelo nao conseguiu predizer o valor?
sum(is.na(error4))

par(mfrow=c(2,2))
plot(error, main=paste("Erro do modelo 1, MAE = ",mae(error)), ylim=c(-20000000,20000000))
abline(0,0, col='red')
plot(error2, main=paste("Erro do modelo 2, MAE = ",mae(error2)), ylim=c(-20000000,20000000))
abline(0,0, col='red')
plot(error3, main=paste("Erro do modelo 3, MAE = ",mae(error3)), ylim=c(-20000000,20000000))
abline(0,0, col='red')
plot(error4, main=paste("Erro do modelo 4, MAE = ",mae(error4)), ylim=c(-20000000,20000000))
abline(0,0, col='red')

par(mfrow=c(2,2))
plot(error, main=paste("Erro do modelo 1, MAE = ",mae(error)))
abline(0,0, col='red')
plot(error2, main=paste("Erro do modelo 2, MAE = ",mae(error2)))
abline(0,0, col='red')
plot(error3, main=paste("Erro do modelo 3, MAE = ",mae(error3)))
abline(0,0, col='red')
plot(error4, main=paste("Erro do modelo 4, MAE = ",mae(error4)))
abline(0,0, col='red')