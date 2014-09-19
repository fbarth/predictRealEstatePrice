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
      selectInput('bairro', 'Neighborhood name', c('paraiso',
                                        'perto_ibirapuera',
                                        'vila-mariana',                              
                                        'vila-nova-conceicao',
                                        'vila-sonia')), 
      numericInput('area', 'Size (m2)', 90),
      numericInput('dormitorios', 'Bedrooms', 1, min = 0, max = 10, step = 1),
      numericInput('suites', 'Bedrooms with Bathrooms', 1, min = 0, max = 10, step = 1),
      numericInput('vagas', 'Carspaces', 1, min = 0, max = 10, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Real Estate Price:'),
      verbatimTextOutput("prediction"),
      p("The price show above is in Brazilian real (BRL)."),
      p("The options that you can select in neighborhood attribute are: Paraíso, \"perto 
        do Ibirapuera\", Vila Mariana, Vila Nova Conceição and Vila Sônia. Paraíso, Vila
        Mariana and Vila Nova Conceição are neighborhood located near to downtown and 
        Paulista Avenue. \"Perto do Ibirapuera\" is not a formal neigborhood, it is a part
        of Vila Mariana neigborhood that is located near to Ibirapuera park, the most
        famous park of Sao Paulo city. Vila Sonia is part of suburb of Sao Paulo."),
      p("In the size field you can select the size of apartment in meters."),
      p("The other fields are used to indicate how many bedrooms, bedrooms with 
        bathrooms and carspaces the apartment have.")
    )
  )
)