# R Shiny Workshop
:spiral_calendar: Wednesday 1 March 2023

:books: [Workshop slides](https://hackmd.io/@evelina/shiny-slides#/)

## Part 1 : Getting Started

1. Install Shiny by running the following command in R command line:

  install.packages("shiny")

2. Go into the `tasks` directory and look at the contents of the `part1` folder. This folder contains a file called `app.R`. This is the file that contains the code for the Shiny app. 
  - Open this file in RStudio and run the app by clicking the "Run App" button in the top right corner of the script window.
  - I you're using a different editor, you can run the app from R command line using the `runApp` function with the app directory as an argument. In this case, run `runApp("tasks/part1")` in the R command line from the parent directory.

3. Identify the different parts of a Shiny app:
  - `ui` object - the  user interface
  - `server` function - the computational logic of the application
  - `shinyApp` function - the function that puts together the UI and the server into an application

4. Go through the tasks in the `app.R` file to add a new plot into the app. The tasks are marked with `# TASK` comments.

## Part 2 : Covid-19 dashboard

1. Look at the `data.gov.uk` website for covid-19: https://coronavirus.data.gov.uk/
  We will replicate some of the plots from this website and add interactivity.

2. Look into the `tasks/part2` folder. This folder contains `app.R` with a skeleton application and a folder with the data downloaded from the `data.gov.uk` website in the `csv` format. Run the app.

3. Go through the tasks in the `app.R` file. The tasks are again marked with `# TASK` comments.

## Part 3 : Adding more interactivity 

In this part, we will add even more interactivity to the dashboard developed in Part 2. We will add an option to select a region of a plot and display summaries of that region in a table. As in the previous parts, look into the `part3` folder and follow the instructions.

Useful links:
- [Shiny function reference](https://shiny.rstudio.com/reference/shiny/1.7.4/)
- [Selecting rows of data](https://shiny.rstudio.com/articles/selecting-rows-of-data.html)

## Part 4: Bonus task

Look at how to download data for different regions from the `data.gov.uk` website at [the download page](https://coronavirus.data.gov.uk/details/download). The page provides an API link to download the data in `csv` format.You can use the request directly in the `read_csv` function instead of a file location. 

Task: Add a text box to the app that allows the user to enter a region name, then download and display the data for that region. 

Note: The data used in the Parts 2 and 3 were downloaded using the following request:

  https://api.coronavirus.data.gov.uk/v2/data?areaType=nation&areaCode=E92000001&metric=newAdmissions&metric=newCasesBySpecimenDate&metric=newDailyNsoDeathsByDeathDate&format=csv&release=2023-02-23


## Useful links

- [Shiny function reference](https://shiny.rstudio.com/reference/shiny/1.7.4/)
- [Shiny tutorial](https://shiny.rstudio.com/tutorial/)
- [Shiny gallery](https://shiny.rstudio.com/gallery/)


