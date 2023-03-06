library(shiny)
library(tidyverse)

covid_data <- read_csv("data/nation_2023-02-23.csv")



#-----------------------------------

ui <- fluidPage(
  titlePanel("Covid-19 in Englang - Shiny demo"),
  hr(),
  fluidRow(
    column(width = 4,

      h3("People tested positive in England"),
      plotOutput(outputId = "testedPositivePlot")
    
    ),
    column(width = 4,
    
      h3("Deaths with Covid-19 on death certificate in England"),

      # TASK 1: Add a plot that will show the number of deaths with Covid-19 on death certificate in England
      # Use the `testedPositivePlot` as a template
      "Placeholder for plot"

    ),
    column(width = 4,

      h3("Patients admitted in England"),

      # TASK 3: Add a plot that will show the number of patients admitted to hospital in England
      # Use the `testedPositivePlot` as a template
      "Placeholder for plot"

    )
  ),

  fluidRow(
    column(width=5, 
      h2("Controls"),

      h3("Date range"),
      # TASK 5: Let's add interactivity! 
      # First, add an option to select start and end date for the plots
      # Use the dateInput element, the documentation for dateInput is available here: https://shiny.rstudio.com/reference/shiny/1.7.4/dateinput
      # Create two dateInput elements, one for the start date and one for the end date
      # Example usage: 
      #   dateInput("selectedDate", "Enter date:", value = "2022-09-01")
      # Creates a date input element with "Enter date:" label, default value of the 1 September 2022
      # and the resulting value is then stored in `input$selectedDate`.


      h3("Log scale"),
      # TASK 7: Number of infections grows  exponentially, here we will add an option 
      # to switch between normal and logarithmic scale for the y-axis
      # Use the checkboxInput element.
      # Example usage:
      #   checkboxInput("transformation", "Log scale", value = TRUE)
      # Creates a checkbox input element with "Log scale" label, default value of TRUE
      # and the resulting value is then stored in `input$transformation`.

      h3("Smoothing"),
      # TASK 9: Bonus task! Let's add an option to smooth the data to make it easier to see the trend.
      # Add a checkbox to enable/disable smoothing,
      # then explore the `sliderInput` element to allow user to adjust the smoothing parameter.
      # You will have to adjust the plotting functions on the server to use
      # `geom_smooth` instead of `geom_line` if smoothing is enabled.


      ,
      offset = 1 # offset the controls from the left side of the page
    )
  ),
)

server <- function(input, output) {

  output$testedPositivePlot <- renderPlot({

    # TASK 6: From task 5, you should have the stard and end dates for the plots.
    # The task is now to filter the `covid_data` to include only the specified date range.
    # Use the `filter` function on the covid_data data frame, 
    # you can filter based on a date directly by using something like
    #    covid_data |> filter(date >= startDate)

    # TASK 8: From task 7, you should have the value of the checkbox that determines
    # whether the y-axis should be in log scale or not.
    # The task is now to use the `trans` argument in the `scale_y_continuous` function
    # to set the transformation to "log10" if the checkbox is checked and "identity" otherwise.

    covid_data |>
      ggplot(aes(x = date, y = newCasesBySpecimenDate)) +
      geom_line(colour="black")  +
      theme_minimal() +
      labs(title = "New cases by specimen date",
           x = "Date",
           y = "Number of cases") +
      scale_y_continuous(trans="identity") 

  })

  # TASK 2: Add a server function that will render the plot 
  # for the number of deaths with Covid-19 on death certificate in England
  # and store in the output variable used in the plotOutput function in the UI


  # TASK 4: Add a server function that will render the plot
  # for the number of patients admitted to hospital in England
  # and store in the output variable used in the plotOutput function in the UI

}

shinyApp(ui, server)