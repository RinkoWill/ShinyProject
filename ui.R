library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Real Estate Deal Analyzer"),
  
  # Sidebar with a sliders for all of the inputs
  sidebarLayout(
    sidebarPanel(
        sliderInput("repaircost",
                    "Estimated Repair Costs",
                    min = 0,
                    max= 50000,
                    value=c(15000,30000),
                    step=100,
                    sep=",",
                    pre="$"),
        sliderInput("monthcost",
                    "Monthly Loan and Tax Cost",
                    min = 0,
                    max= 5000,
                    value=1000,
                    step=100,
                    sep=",",
                    pre="$"),
        sliderInput("months",
                   "Months Needed for Repair:",
                   min = 1,
                   max = 12,
                   value = 3,
                   step=1),
        sliderInput("sellprice",
                    "House Value After Repairs",
                    min = 0,
                    max= 500000,
                    value=100000,
                    step=5000,
                    sep=",",
                    pre="$"),
        sliderInput("return",
                   "Return on Cash Desired:",
                   min = 0,
                   max = 100,
                   value = 9,
                   step=1,
                   post="%")

    ),
    
    # Show the Bid Price and plot
    mainPanel(
       h4("This is the minimum bid you should make on the property."),
       textOutput("bid.low"),
       h4("This is the maximum bid you should make on the property."),
       textOutput("bid.high"),
       plotOutput("plot")
    ),
    wellPanel(
            helpText(   a("Click Here to Download Survey",     href="http://www.dfcm.utoronto.ca/Assets/DFCM2+Digital+Assets/Family+and+Community+Medicine/DFCM+Digital+Assets/Faculty+$!26+Staff/DFCM+Faculty+Work+$!26+Leadership+Survey+Poster.pdf")
            )
    )
  )
))
