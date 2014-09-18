library(ggplot2)

# carga de dados e eliminacao de outliers

load("data//20140917_imoveis_filtrados.Rda")
data <- imoveis_filtrados
sapply(data, summary)
data <- subset(data, data$area > 10)
data <- subset(data, data$suites < 11)
data$bairro <- factor(data$bairro)

# plot dos dados

qplot(data$area, data$preco, shape=data$bairro, size=data$suites, col=data$vagas)
qplot(log(data$area), log(data$preco), shape=data$bairro, size=data$suites, col=data$vagas)

with(data[data$bairro == 'perto_ibirapuera' | data$bairro == 'vila-sonia',], 
     qplot(area, preco, size=suites, col=bairro))

# criando o modelo de regressao

model0 <- lm(log(preco) ~ bairro + log(area) + dormitorios + suites + vagas + banheiros,
            data=data)
summary(model0)

model <- lm(log(preco) ~ bairro + log(area) + dormitorios + suites + vagas,
            data=data)
summary(model)

save(model, file="form_apartment_price/model.Rda")
