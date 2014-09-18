load('data/imoveis_completo.rda')
op <- par(no.readonly = TRUE)

names(imoveis)
sapply(imoveis,class)

summary(imoveis$preco)
summary(imoveis$area)
summary(imoveis$dormitorios)
summary(imoveis$vagas)
summary(imoveis$suites)
summary(imoveis$banheiros)
summary(imoveis$bairro)

par(mai = c(1.5, 1, 0.1, 0.1), las = 2, cex.axis = 0.5)
#boxplot(imoveis$preco ~ imoveis$bairro)
boxplot(imoveis$preco ~ imoveis$bairro, outline=FALSE, col='green')

par(mai = c(1.5, 0.8, 0.1, 0.1), las = 2, cex.axis = 0.5)
barplot(sort(table(imoveis$bairro), decreasing = TRUE), col='cyan')

par(op)
par(mfrow=c(2,2))
with(imoveis[imoveis$bairro == 'cidade-jardim',], plot(preco ~ area, pch=19, 
                                                       ylim=c(0,50000000)))
with(imoveis[imoveis$bairro == 'paraiso',], plot(preco ~ area, pch=19,
                                                 ylim=c(0,50000000)))
with(imoveis[imoveis$bairro == 'vila-mariana',], plot(preco ~ area, pch=19,
                                                 ylim=c(0,50000000)))
with(imoveis[imoveis$bairro == 'moema',], plot(preco ~ area, pch=19,
                                                 ylim=c(0,50000000)))

with(imoveis[imoveis$bairro == 'cidade-jardim',], plot(preco ~ area, pch=19, 
                                                       ylim=c(0,2000000)))
with(imoveis[imoveis$bairro == 'paraiso',], plot(preco ~ area, pch=19,
                                                 ylim=c(0,2000000)))
with(imoveis[imoveis$bairro == 'vila-mariana',], plot(preco ~ area, pch=19,
                                                      ylim=c(0,2000000)))
with(imoveis[imoveis$bairro == 'moema',], plot(preco ~ area, pch=19,
                                               ylim=c(0,2000000)))

library(psych)
pairs.panels(imoveis[,c('preco','area','suites','dormitorios','banheiros','vagas')])

vila_mariana <- subset(imoveis, imoveis$bairro == 'vila-mariana')
pairs.panels(vila_mariana[,c('preco','area','suites','dormitorios','banheiros','vagas')])

paraiso <- subset(imoveis, imoveis$bairro == 'paraiso')

save(vila_mariana, file="data/vila_mariana.Rda")
save(paraiso, file="data/paraiso.Rda")
