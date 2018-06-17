library(shiny)
library(shinyjs)
library(ggplot2)
library(ausBeerTax)
library(png)
library(grid)
img <- readPNG(system.file("shiny-examples", "ausBeerTax", "beer5.png",
                           package = "ausBeerTax"))
g <- rasterGrob(img, interpolate = TRUE)

server <- function(input, output, session) {
    ## Just a simple vector output for the moment, consisting of GST amount,
    ## excise amount, and remainder.
    amounts <- reactive({
        gst <- ausBeerTax::calcGST(input$slabCost)
        excise <- ausBeerTax::calcExcise(input$abv / 100, input$vol, input$num)
        c(excise, gst, input$slabCost - gst - excise)
    })
    
    output$bar <- renderPlot({
        amt <- amounts()
        bar <- data.frame(
            Component = c("Excise", "GST", "Non-tax Amount"),
            vals = amt,
            perc = amt / input$slabCost,
            pos = c(amt[3] / 2, amt[3] + amt[2] / 2,
                    amt[3] + amt[2] + amt[1] / 2)
        )
        pl <- ggplot(bar, aes(x = "Beer Cost Components",
                              fill = Component, y = vals)) +
            geom_col() +
            geom_text(aes(label = sprintf("$%.2f\n%.0f%%", rev(vals),
                                          rev(perc*100)), y = pos)) +
            xlab("") +
            ylab("$ Share") +
            annotation_raster(img, xmin = -Inf, xmax = Inf,
                              ymin = -Inf, ymax = Inf, interpolate = TRUE) +
            theme_classic()
        print(pl)
    })

    output$txt <- renderText({
        amt <- amounts()
        tax <- round((amt[1] + amt[2]) / sum(amt) * 100)
        text <- paste0("If you purchased ", input$num, ", ", input$vol,
                       "ml bottles/cans of sweet amber nectar at a cost of $",
                       input$slabCost, ", and your beer contained ", input$abv,
                       "% alcohol by volume, then you'd be paying $", amt[2],
                       " in GST, and $", amt[1],
                       " in excise to the government. That's ", tax,
                       "% of the total cost of your beer in taxes.")
        text
    })

    ## Change input if VB is selected...
    observeEvent(input$vb, {
        updateNumericInput(session, "slabCost", value = 47.95)
        updateSliderInput(session, "abv", value = 4.9)
        updateSliderInput(session, "vol", value = 375)
        updateSliderInput(session, "num", value = 24)
    })

    ## Change input if Coopers pale is selected...
    observeEvent(input$coop, {
        updateNumericInput(session, "slabCost", value = 48.95)
        updateSliderInput(session, "abv", value = 4.5)
        updateSliderInput(session, "vol", value = 375)
        updateSliderInput(session, "num", value = 24)
    })

    ## Change input if little creatures is selected...
    observeEvent(input$crea, {
        updateNumericInput(session, "slabCost", value = 65.90)
        updateSliderInput(session, "abv", value = 5.2)
        updateSliderInput(session, "vol", value = 330)
        updateSliderInput(session, "num", value = 24)
    })

    ## Change input if furphys is selected...
    observeEvent(input$furp, {
        updateNumericInput(session, "slabCost", value = 47.95)
        updateSliderInput(session, "abv", value = 4.4)
        updateSliderInput(session, "vol", value = 375)
        updateSliderInput(session, "num", value = 24)
    })
    
}
