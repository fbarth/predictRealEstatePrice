library(rjson)

cria_dataset_a_partir_api <- function(json_data, nm_bairro){
  dataset <- data.frame(preco = character(0), area = character(0), 
                        dormitorios = character(0), vagas = character(0), 
                        suites = character(0), banheiros = character(0), 
                        descricao=character(0), atualizacao = character(0),
                        bairro=character(0))
  names(dataset) <- c('preco','area','dormitorios','vagas','suites','banheiros',
                      'descricao', 'atualizacao', 'bairro')

  for (i in 1:length(json_data$results$imoveis)){
    lista <- list(preco=json_data$results$imoveis[[i]]$preco,
                  area=json_data$results$imoveis[[i]]$area,
                  dormitorios=json_data$results$imoveis[[i]]$dormitorios,
                  vagas=json_data$results$imoveis[[i]]$vagas,
                  suites=json_data$results$imoveis[[i]]$suites,
                  banheiros=json_data$results$imoveis[[i]]$banheiros,
                  descricao=json_data$results$imoveis[[i]]$descricao,
                  atualizacao=json_data$results$imoveis[[i]]$atualizacao,
                  bairro=nm_bairro)
    dataset <- rbind(dataset, as.data.frame(lista))
  }
  
  dataset$preco <- as.numeric(paste(gsub("\\.","",gsub("R\\$ ","",dataset$preco))))
  dataset$area <- as.numeric(paste(gsub("m.","",dataset$area)))
  dataset$vagas <- as.numeric(paste(dataset$vagas))
  dataset$dormitorios <- as.numeric(paste(dataset$dormitorios))
  dataset$suites <- as.numeric(paste(dataset$suites))
  dataset$banheiros <- as.numeric(paste(dataset$banheiros))
  dataset$atualizacao <- as.Date(paste(dataset$atualizacao), format="%d-%m-%Y")
  
  return (dataset)
}

dt_pinheiros <- cria_dataset_a_partir_api(
  fromJSON(file="data/pinheiros.json"),"pinheiros")

dt_pirituba <- cria_dataset_a_partir_api(
  fromJSON(file="data/pirituba.json"),"pirituba")

dt_vila_mariana <- cria_dataset_a_partir_api(
  fromJSON(file="data/vila_mariana.json"),"vila_mariana")

imoveis <- rbind(dt_pinheiros, dt_pirituba)
imoveis <- rbind(imoveis, dt_vila_mariana)

save(imoveis, file="data/imoveis.rda")

























