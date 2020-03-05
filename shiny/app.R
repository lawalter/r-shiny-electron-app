# Copyright (c) 2020 L. Abigail Walter

# An example R Shiny script 
# This app generates random bird band color combinations

# libraries ---------------------------------------------------------------

library(shiny)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)

# ui ----------------------------------------------------------------------

# Define UI for application:

ui <- fluidPage(

  # Application title:
  titlePanel("Color Band Combination Generator"),

  # Sidebar with input options:
  sidebarLayout(
    sidebarPanel(

      checkboxGroupInput("colorVector",
                         "Colors available:",
                         choices = list("[X] Aluminum" = "X",
                                        "[R] Red" = "R", 
                                        "[O] Orange" = "O",
                                        "[Y] Yellow" = "Y", 
                                        "[G] Green" = "G",
                                        "[B] Blue" = "B", 
                                        "[M] Purple" = "M",
                                        "[P] Pink" = "P", 
                                        "[W] White" = "W",
                                        "[K] Black" = "K", 
                                        "[E] Grey" = "E"),
                         selected = c("X", "R", "O", "Y", "G", "B", "W"))
    ),

    # Show a plot of the generated distribution:
    mainPanel(
      verbatimTextOutput("colorVect"),
      tableOutput("view")
    )
  )
)

# server ------------------------------------------------------------------

# Define color combo function:

get_colors <-
  function(x) {
    as_tibble(x) %>%
      transmute(color = value) %>%
      # All potential combos of left and right legs:
      expand(left = color,
             right = color) %>%
      unite('color', sep = '') %>%
      expand(left = color,
             right = color) %>%
      # Unite as a single column:
      unite('color', sep = '') %>%
      # Filter for correct number of bands:
      filter(str_count(color, '[A-Z]') == 4) %>%
      {if("X" %in% x){
        filter(
          .,
          # Keep combos with one, and only one, aluminum:
          str_count(.$color, 'X') == 1)
      } else .} %>%
      # Randomize output:
      sample_n(size = nrow(.))
  }

# Define server logic:

server <- function(input, output) {

  dataInput <- reactive({
    get_colors(input$colorVector)
  })

  output$view <- renderTable({
    dataInput()
  })

  output$colorVect <- renderText(input$colorVector)

}

# run ---------------------------------------------------------------------

# Run the application:

shinyApp(ui = ui, server = server)

