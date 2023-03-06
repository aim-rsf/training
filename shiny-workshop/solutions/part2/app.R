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
      plotOutput(outputId = "deathsPlot")
    ),
    column(width = 4,
      h3("Patients admitted in England"),
      plotOutput(outputId = "admissionsPlot")
    )
  ),

  fluidRow(
    column(width=5, 
      h2("Controls"),

      h3("Date range"),
      dateInput("startDate", "Start date:", value = "2022-09-01"),
      # Default value is the date in client's time zone
      dateInput("endDate", "End date:"),
      
      h3("Smoothing"),
      checkboxInput("smooth", "Smooth data", value = TRUE),
      conditionalPanel(
        condition = "input.smooth",
        sliderInput("smoothingSpan", "Loess span parameter:", min = 0.015, max = 0.3, value = 0.1, step = 0.01),
      ),

      h3("Log scale"),
      checkboxInput("logScale", "Log scale", value = FALSE),
      offset = 1
    )
  ),
)

server <- function(input, output) {

  output$testedPositivePlot <- renderPlot({
    if (input$logScale) {trans="log10"} else {trans="identity"}

    covid_data |>
      filter(date >= input$startDate & date <= input$endDate) |>
      ggplot(aes(x = date, y = newCasesBySpecimenDate)) +
      { if(input$smooth)  geom_smooth(colour = "black", se = FALSE, span=input$smoothingSpan) else  geom_line(colour="black") } +
      theme_minimal() +
      labs(title = "New cases by specimen date",
           x = "Date",
           y = "Number of cases") +
      scale_y_continuous(trans=trans) 
  })

  output$deathsPlot <- renderPlot({
    if (input$logScale) {trans="log10"} else {trans="identity"}

    covid_data |>
      filter(date >= input$startDate & date <= input$endDate) |>
      ggplot(aes(x = date, y = newDailyNsoDeathsByDeathDate)) +
      { if(input$smooth) geom_smooth(colour = "black", se = FALSE, span=input$smoothingSpan) else geom_line(colour="black") } +
      theme_minimal() +
      labs(title = "New registered deaths by death date",
           x = "Date",
           y = "Number of deaths") +
      xlim(input$startDate, input$endDate)  +
      scale_y_continuous(trans=trans)
  })

  output$admissionsPlot <- renderPlot({
    if (input$logScale) {trans="log10"} else {trans="identity"}

    covid_data |>
      filter(date >= input$startDate & date <= input$endDate) |>
      ggplot(aes(x = date, y = newAdmissions)) +
      { if(input$smooth) geom_smooth(colour = "black", se = FALSE, span=input$smoothingSpan) else geom_line(colour="black") } +
      theme_minimal() +
      labs(title = "New hospital admissions",
           x = "Date",
           y = "Number of admissions") +
      xlim(input$startDate, input$endDate)  +
      scale_y_continuous(trans=trans)
  })


}

shinyApp(ui, server)