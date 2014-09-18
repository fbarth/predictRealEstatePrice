shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Real Estate Price Prediction"),
    
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
      h3('Results of prediction'),
      #h4('You entered'),
      #verbatimTextOutput("inputValue"),
      #h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction")
    )
  )
)