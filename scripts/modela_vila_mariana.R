load('data/vila_mariana.Rda')
summary(vila_mariana)

vila_mariana <- vila_mariana[complete.cases(vila_mariana),]
vila_mariana <- vila_mariana[vila_mariana$preco > 200000,]
summary(vila_mariana)

#
# tentativa de clusterizar os imoveis
#

dataset <- vila_mariana
dataset$preco <- dataset$preco / max(dataset$preco)
dataset$area <- dataset$area / max(dataset$area)
dataset$suites <- dataset$suites / max(dataset$suites)
dataset$dormitorios <- dataset$dormitorios / max(dataset$dormitorios)
dataset$banheiros <- dataset$banheiros / max(dataset$banheiros)
dataset$vagas <- dataset$vagas / max(dataset$vagas)
dataset$bairro <- NULL
dataset$descricao <- NULL
summary(dataset)

set.seed(1234)
elbow <- function(dataset) {
  wss <- numeric(25)
  for (i in 1:25) wss[i] <- sum(kmeans(dataset, centers = i, nstart = 100)$withinss)
  plot(2:25, wss[2:25], type = "b", main = "Elbow method", xlab = "Number of Clusters", 
       ylab = "Within groups sum of squares", pch = 8)
}

elbow(dataset)

cluster_model <- kmeans(dataset, centers = 14, nstart = 100)
table(cluster_model$cluster)
cluster_model$withinss

#
# fim tentativa clusterizar imoveis
#

mae <- function(error)
{
  mean(abs(error))
}

library(psych)
pairs.panels(vila_mariana[,c('preco','area','suites','dormitorios','banheiros','vagas')])

model <- lm(preco ~ area + suites + dormitorios + banheiros + vagas, data=vila_mariana)
model2 <- lm(preco ~ area + suites + dormitorios + vagas, data=vila_mariana)
model3 <- lm(log(preco) ~ area + suites + dormitorios + banheiros + vagas, data=vila_mariana)
model4 <- lm(log(preco) ~ area + suites + dormitorios + vagas, data=vila_mariana)
error1 <- vila_mariana$preco - predict(model,vila_mariana)
mae1 <- mae(error1)
error2 <- vila_mariana$preco - predict(model2,vila_mariana)
mae2 <- mae(error2)
error3 <- vila_mariana$preco - exp(predict(model3,vila_mariana))
mae3 <- mae(error3)
error4 <- vila_mariana$preco - exp(predict(model4,vila_mariana))
mae4 <- mae(error4)

par(mfrow=c(2,2))
plot(error1, main=paste("Resíduos do modelo 1 - MAE = ",mae1))
abline(0,0, col='red', lwd=2)
plot(error2, main=paste("Resíduos do modelo 2 - MAE = ",mae2))
abline(0,0, col='red', lwd=2)
plot(error3, main=paste("Resíduos do modelo 3 - MAE = ",mae3))
abline(0,0, col='red', lwd=2)
plot(error4, main=paste("Resíduos do modelo 4 - MAE = ",mae4))
abline(0,0, col='red', lwd=2)
