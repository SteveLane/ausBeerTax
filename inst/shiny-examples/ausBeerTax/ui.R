library(shiny)
library(shinyjs)
library(ausBeerTax)

fluidPage(
    useShinyjs(),
    title = "Australian Beer Tax",
    ## fluidRow(
    ##     plotOutput("bar", width = "300px")
    ## ),
    ## ## I should try and plot something, but just place some text now.
    ## ## fluidRow(
    ## ##     column(
    ## ##         12, p("Here's some text about the app.")
    ## ##     )
    ## ## ),
    ## hr(),
    fluidRow(
        column(
            3, plotOutput("bar", width = "300px")
        ),
        column(
            3, h4("About"),
            HTML("Beer is ridiculously expensive in Australia. A major chunk of your hard-earned is an excise that goes to the Australian government (see <a href='https://www.ato.gov.au/Business/Excise-and-excise-equivalent-goods/Alcohol-excise/Excise-rates-for-alcohol/'>here</a> for details). This app allows you to calculate exactly how much excise you're paying when you purchase that slab!"),
            p(""),
            textOutput("txt")
        ),
        column(
            3, h4("Change for your favourite beer."),
            numericInput(
                'slabCost', 'Cost of Slab', 
                min = 1, max = 150, value = 49.90,
                step = 1
            ),
            sliderInput(
                'abv', 'Alcohol content (%)', 
                min = 0, max = 15, value = 4.9,
                step = 0.1
            ),
            sliderInput(
                'vol', 'Volume per Bottle (ml)', 
                min = 1, max = 750, value = 375,
                step = 1
            ),
            sliderInput(
                'num', 'Number of Bottles', 
                min = 1, max = 48, value = 24,
                step = 1
            )
        ),
        column(
            3, h4("Click the buttons for some popular beer settings."),
            p("The price settings for these were current from a 'big box' store on 2018-06-17."), br(),
            actionButton("vb", "VB"), br(),
            actionButton("coop", "Coopers Pale Ale"), br(),
            actionButton("crea", "Little Creatures Pale Ale"), br(),
            actionButton("furp", "Furphy's")
        )
    )
)
