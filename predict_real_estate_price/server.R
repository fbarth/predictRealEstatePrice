price <- function(bairro, area, dormitorios, suites, vagas){
  v <- c(bairro, area, dormitorios, suites, vagas)
  d <- data.frame(bairro=v[1],
                  area=as.numeric(v[2]),
                  dormitorios = as.numeric(v[3]), 
                  suites = as.numeric(v[4]), 
                  vagas=as.numeric(v[5]))
  load('model.Rda')
  return (exp(predict(model, newdata=d)))
}

shinyServer(
  function(input, output) {
    output$prediction <- renderPrint({
      paste("R$", 
            format(price(input$bairro,input$area,input$dormitorios,input$suites,input$vagas),
                   decimal.mark=",", big.mark=".", small.mark="."
                   )
      )
      })
  }
)