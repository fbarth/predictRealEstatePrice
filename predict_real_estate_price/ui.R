shinyUI(
  fluidPage(
    # Application title
    fluidRow(
      h1("Residential Real Estate Prices Prediction"),
      p("The goal of this app is predict residential real estate (apartment) 
        prices in Sao Paulo, Brazil."),
      p("You can select the residential real estate attributes in the left 
        menu and see the price in the right side.")
      ),    
    sidebarPanel(
      selectInput('bairro', 'Neighborhood', c('paraiso',
                                        'perto_ibirapuera',
                                        'vila-mariana',                              
                                        'vila-nova-conceicao',
                                        'vila-sonia')), 
      numericInput('area', 'Area (m2)', 90),
      numericInput('dormitorios', 'Bedrooms', 1, min = 0, max = 10, step = 1),
      numericInput('suites', 'Bedrooms with Bathrooms', 1, min = 0, max = 10, step = 1),
      numericInput('vagas', 'Carspaces', 1, min = 0, max = 10, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Real Estate Price:'),
      verbatimTextOutput("prediction"),
      p("The price show above is in Brazilian real (BRL)")
    )
  )
)