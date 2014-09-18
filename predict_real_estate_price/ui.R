shinyUI(
  fluidPage(
    # Application title
    fluidRow(
      h1("Real Estate Prices Prediction"),
      p("The goal of this app is predict real estate prices in Sao Paulo, Brazil."),
      p("You can select the real estate attributes in the left menu and see the 
        price in the right side.")
      ),    
    sidebarPanel(
      selectInput('bairro', 'Bairro', c('paraiso',
                                        'perto_ibirapuera',
                                        'vila-mariana',                              
                                        'vila-nova-conceicao',
                                        'vila-sonia')), 
      numericInput('area', 'Area (m2)', 90),
      numericInput('dormitorios', 'Dormitórios', 1, min = 0, max = 10, step = 1),
      numericInput('suites', 'Suites', 1, min = 0, max = 10, step = 1),
      numericInput('vagas', 'Vagas', 1, min = 0, max = 10, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Real Estate Price:'),
      verbatimTextOutput("prediction"),
      p("The price show above is in Brazilian real (BRL)")
    )
  )
)