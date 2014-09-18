library(rCharts)
load('data/vila_mariana.Rda')
load('data/paraiso.Rda')

vila_mariana <- vila_mariana[vila_mariana$preco <= 1500000,]
vila_mariana <- vila_mariana[vila_mariana$vagas >= 2,]
vila_mariana <- vila_mariana[vila_mariana$dormitorios >= 3,]

paraiso <- paraiso[paraiso$preco <= 1500000,]
paraiso <- paraiso[paraiso$vagas >=2, ]
paraiso <- paraiso[paraiso$dormitorios >= 3,]

imoveis <- rbind(vila_mariana, paraiso)

p <- nPlot(preco ~ area, group=c('dormitorios'), data=imoveis, type='scatterChart')
p$chart(tooltipContent = "#! function(key, x, y, e){ return e.point.descricao + 'Bairro' +
        e.point.bairro + 'Vagas '+ e.point.vagas} !#")
p$save('results/imoveis.html')
