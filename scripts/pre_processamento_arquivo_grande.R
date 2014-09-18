dataset <- read.csv("data/20140917_imoveis.csv", sep=";", quote="")
dataset$preco <- as.numeric(paste(gsub("\\.","",gsub("R\\$ ","",dataset$preco))))
dataset$area <- as.numeric(paste(gsub("m","",dataset$area)))
dataset$vagas <- as.numeric(paste(dataset$garagem))
dataset$garagem <- NULL
dataset$dormitorios <- as.numeric(paste(dataset$dormitorios))
dataset$suites <- as.numeric(paste(dataset$suites))
dataset$banheiros <- as.numeric(paste(dataset$banheiros))
dataset$descricao <- as.character(paste(dataset$descricao))

imoveis <- dataset
save(imoveis, file="data/20140917_imoveis_completo.rda")
#load('data//20140917_imoveis_completo.rda')

imoveis_filtrados_por_bairro <- imoveis[imoveis$bairro == 'paraiso' | 
                               imoveis$bairro == 'vila-nova-conceicao' |
                                 imoveis$bairro == 'vila-sonia',]

imoveis_perto_ibirapuera <- imoveis[imoveis$bairro == 'vila-mariana' & 
                                      (regexpr("ibirapuera", imoveis$descricao) > -1),]
imoveis_perto_ibirapuera$bairro <- "perto_ibirapuera"

imoveis_vila_mariana <- imoveis[imoveis$bairro == 'vila-mariana' & 
                                      (regexpr("ibirapuera", imoveis$descricao) == -1),]

imoveis_filtrados <- rbind(imoveis_filtrados_por_bairro, imoveis_perto_ibirapuera)
imoveis_filtrados <- rbind(imoveis_filtrados, imoveis_vila_mariana)
imoveis_filtrados$bairro <- factor(imoveis_filtrados$bairro)

save(imoveis_filtrados, file="data/20140917_imoveis_filtrados.Rda")
