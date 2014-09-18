load('data/imoveis.rda')

names(imoveis)
sapply(imoveis,class)

summary(imoveis$preco)
summary(imoveis$area)
summary(imoveis$dormitorios)
summary(imoveis$vagas)
summary(imoveis$suites)
summary(imoveis$banheiros)
summary(imoveis$bairro)

# para nao imprimir em notacao cientifica
options(scipen=5)

par(mfrow=c(1,3))
with( imoveis[imoveis$bairro == 'pirituba',], 
      boxplot(preco, main="Preco dos imóveis em Pirituba",
              ylim=c(0,7000000)))
with( imoveis[imoveis$bairro == 'pinheiros',], 
      boxplot(preco, main="Preco dos imóveis em Pinheiros",
              ylim=c(0,7000000)))
with( imoveis[imoveis$bairro == 'vila_mariana',], 
      boxplot(preco, main="Preco dos imóveis na Vila Mariana",
              ylim=c(0,7000000)))

par(mfrow=c(1,2))
plot(imoveis$preco ~ imoveis$area, pch=21, 
     bg=c('red','green','yellow')[as.numeric(imoveis$bairro)])

with( imoveis[imoveis$bairro != 'vila_mariana', ], 
      plot(preco ~ area, pch=21, bg=c('red','green','yellow')[as.numeric(bairro)]) )

library(psych)
pairs.panels(imoveis[,1:6])

