library(shiny)
library(ggplot2)


# Basic user interface
# Page is a container for list of elements that define the user interface
# Examples of elements: panels, layouts

ui <- fluidPage(

  titlePanel("Hello world"),

  mainPanel(

      numericInput(inputId = "n", label = "Number of samples", value = 1000),
      plotOutput(outputId = "impressivePlot"),
      plotOutput(outputId = "moreImpressivePlot")

      # TASK 1: Add a new plot to the user interface
  )
)

# Background logic of the application
# Server is a function that takes two arguments: input and output
# Input contains the values of the user interface elements
# Output is a list of "reactive" expressions that are displayed in the user interface

server <- function(input, output) {

  # renderPlot creates a reactive plot that automatically changes or "reacts" to user changes
  output$impressivePlot <- renderPlot({
    n <- input$n
    x <- 1:n
    y <- rnorm(n)
    df <- data.frame(x, y)
    ggplot(df, aes(x, y)) +
      geom_point(colour = "#c2006b")
    })

  output$moreImpressivePlot <- renderPlot({
    n <- input$n
    x <- 1:n
    y <- rnorm(n)
    df <- data.frame(x, y)
    ggplot(df, aes(y)) +
      geom_density(colour = "#c2006b")
  })  

  # TASK 2: Add a new plot to the server - a histogram of the samples
  # Remember to use the same identifier that you  used in the user interface
  # Hint: use geom_histogram() from ggplot2

}

# Putting everything together
shinyApp(ui = ui, server = server)